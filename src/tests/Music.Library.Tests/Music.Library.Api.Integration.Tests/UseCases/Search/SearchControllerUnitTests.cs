using Microsoft.VisualStudio.TestTools.UnitTesting;
using Music.Library.Api.Integration.Tests.Common;
using Music.Library.Core.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Music.Library.Api.Integration.Tests.UseCases.Search
{
    [TestClass]
    public class SearchControllerTests : IntegrationTestBase
    {
        [TestMethod]
        public async Task SearchAlbums_ShouldReturnNumberOfMatchesGreaterZero()
        {
            var result = await GetAsync<SearchPackage>("/api/search/man/1/10").ConfigureAwait(false);
            Assert.IsTrue(result.ResponseCount > 0, "The search response count is invalid.");
        }

        [TestMethod]
        public async Task SearchAlbums_ShouldReturnListOfOneOrMoreResults()
        {
            var result = await GetAsync<SearchPackage>("/api/search/man/1/10").ConfigureAwait(false);
            Assert.IsTrue(result.Response.Count > 0, "There are no albums.");
        }

        [TestMethod]
        public async Task SearchAlbums_ShouldReturnResultOfTypeListOfRecords()
        {
            var result = await GetAsync<SearchPackage>("/api/search/man/1/10").ConfigureAwait(false);
            Assert.IsInstanceOfType(result.Response, typeof(List<Record>));
        }
    }
}
