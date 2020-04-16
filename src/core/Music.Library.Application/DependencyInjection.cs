using MediatR;
using Microsoft.Extensions.DependencyInjection;
using Music.Library.Application.UseCases.DashBoard;
using Music.Library.Application.UseCases.Search;
using Music.Library.Core.Entities;

namespace Music.Library.Application
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            var serviceCollection = services
                .AddScoped<IRequestHandler<GetSearchRequest, SearchPackage>, GetSearchRequestHandler>()
                .AddScoped<IRequestHandler<GetDashBoardRequest, DashBoardPackage>, GetDashBoardRequestHandler>();

            return services;
        }
    }
}
