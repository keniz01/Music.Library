using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Music.Library.Api.Controllers;
using Music.Library.Application.Features.Search;
using Music.Library.UnitTests.Helpers;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.UnitTests
{
    [TestClass]
    public class SearchControllerUnitTests : DisposableTestBase
    {
        private SearchController _searchController;

        [TestInitialize]
        public void SetUp()
        {
            var response = new GetSearchResponse(TestDataHelper.CreateAlbums(), 1000);
            var mediator = MockHelper.CreateSearchMediator(response);
            _searchController = new SearchController(mediator.Object);
            RegisterForDispose(_searchController);
        }

        [TestMethod]
        public async Task GetAlbumsShouldReturnSearchResponseCount()
        {
            //Act
            var result = (await _searchController.GetAlbums(It.IsAny<string>(),
                It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>())
                    .ConfigureAwait(false) as OkObjectResult)?.Value as GetSearchResponse;

            //Assert
            Assert.IsTrue(result.ResponseCount == 1000, "The search response count is invalid.");
        }

        [TestMethod]
        public async Task GetAlbumsShouldReturnAListOfAtleastOneAlbum()
        {
            //Act
            var result = (await _searchController.GetAlbums(It.IsAny<string>(),
                It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>())
                    .ConfigureAwait(false) as OkObjectResult)?.Value as GetSearchResponse;

            //Assert
            Assert.IsTrue(result.Response.Count > 0, "There are no albums.");
        }

        [TestMethod]
        public async Task GetAlbumsShouldReturnResultOfTypeJsonResult()
        {
            //Act
            var result = await _searchController.GetAlbums(It.IsAny<string>(), 
                It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>())
                .ConfigureAwait(false);

            //Assert
            Assert.IsInstanceOfType(result, typeof(OkObjectResult));
        }

        [TestCleanup]
        public void TearDown() => Dispose();
    }
}
