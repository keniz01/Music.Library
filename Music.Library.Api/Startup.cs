using MediatR;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Music.Library.Core.Features.Search;
using Music.Library.Core.Repositories;
using Music.Library.Repositories;
using System.Reflection;

namespace Music.Library.Api
{
    public class Startup
    {
        public Startup(IConfiguration configuration) => Configuration = configuration;

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddCors();
            services.AddDbContext<MusicDataContext>(service => service
                .UseSqlServer(Configuration.GetConnectionString("MusicDatabase"))
                .UseLoggerFactory(LoggerFactory.Create(builder => builder.AddConsole()))
                .EnableSensitiveDataLogging()
                .ConfigureWarnings(c => c.Log((RelationalEventId.CommandExecuting, LogLevel.Debug))));

            services.AddControllers();
            services.AddMediatR(typeof(Startup).GetTypeInfo().Assembly);
            services.AddScoped<ISearchRepository, SearchRepository>();
            services.AddScoped<IRequestHandler<GetAlbumsRequest, GetAlbumsResponse>, GetAlbumsRequestHandler>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.UseCors(options => options.WithOrigins("http://localhost:3000"));

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
                endpoints.MapGet("/", async context => 
                    await context.Response.WriteAsync("Api listening for requests."));
            });
        }
    }
}
