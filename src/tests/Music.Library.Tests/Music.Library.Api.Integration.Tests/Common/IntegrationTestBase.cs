// <copyright file="DashBoardControllerUnitTests.cs" company="PlaceholderCompany">
// Copyright (c) PlaceholderCompany. All rights reserved.
// </copyright>

using Microsoft.AspNetCore.Mvc.Testing;
using System.Text.Json;
using System.Threading.Tasks;

namespace Music.Library.Api.Integration.Tests.Common
{
    public class IntegrationTestBase
    {
        public async Task<T> GetAsync<T>(string url)
        {
            var factory = new WebApplicationFactory<Startup>();
            var client = factory.CreateClient();
            var message = await client.GetAsync(url).ConfigureAwait(false);
            var response = await message.Content.ReadAsStringAsync().ConfigureAwait(false);

            var options = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            };

            return JsonSerializer.Deserialize<T>(response, options);
        }
    }
}
