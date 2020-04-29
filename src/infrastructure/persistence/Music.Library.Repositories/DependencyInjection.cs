using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Music.Library.Core.Services.Repositories;

namespace Music.Library.Repositories
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddRepositoryServices(this IServiceCollection services, IConfiguration configuration)
        {
            var serviceCollection = services
                .AddScoped<ISearchRepository, SearchRepository>()
                .AddScoped<IDashBoardRepository, DashBoardRepository>()
                .AddDbContext<MusicDataContext>(service => service
                    .UseSqlServer(configuration.GetConnectionString("MusicDatabase"))
                    .UseLoggerFactory(LoggerFactory.Create(builder => builder.AddConsole()))
                    .EnableSensitiveDataLogging()
                    .ConfigureWarnings(c => c.Log((RelationalEventId.CommandExecuting, LogLevel.Debug))));

            return services;
        }
    }
}
