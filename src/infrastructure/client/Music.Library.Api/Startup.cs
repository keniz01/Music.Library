// <copyright file="Startup.cs" company="PlaceholderCompany">
// Copyright (c) PlaceholderCompany. All rights reserved.
// </copyright>

using MediatR;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using Music.Library.Application.UseCases.DashBoard;
using Music.Library.Application.UseCases.Search;
using Music.Library.Core.Entities;
using Music.Library.Core.Services.Repositories;
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
            services.AddScoped<IRequestHandler<GetSearchRequest, SearchPackage>, GetSearchRequestHandler>();
            services.AddScoped<IRequestHandler<GetDashBoardRequest, DashBoardPackage>, GetDashBoardRequestHandler>();
            services.AddScoped<ISearchRepository, SearchRepository>();
            services.AddScoped<IDashBoardRepository, DashBoardRepository>();
            services.AddDbContext<MusicDataContext>(service => service
                .UseSqlServer(Configuration.GetConnectionString("Development"))
                .UseLoggerFactory(LoggerFactory.Create(builder => builder.AddConsole()))
                .EnableSensitiveDataLogging()
                .ConfigureWarnings(c => c.Log((RelationalEventId.CommandExecuting, LogLevel.Debug))));

            services.AddCors();
            services.AddControllers();
            services.AddMediatR(typeof(Startup).GetTypeInfo().Assembly);
            services.AddSwaggerGen(options =>
                options.SwaggerDoc("v1", new OpenApiInfo { Title = "Music Library API", Version = "v1" }));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public static void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment()) app.UseDeveloperExceptionPage();

            app.UseSwagger();
            app.UseSwaggerUI(options => options.SwaggerEndpoint("/swagger/v1/swagger.json", "Music Library API V1"));
            app.UseRouting();
            app.UseCors(options => options.WithOrigins("http://localhost:3000"));
            app.UseEndpoints(endpoints => endpoints.MapControllers());
        }
    }
}
