using MediatR;
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
    public class SearchUnitTests
    {
        [TestMethod]
        public async Task GetAlbumsShouldReturnAListOfAtleastOneAlbum()
        {
            //Arrange
            Mock<IMediator> fakeMediator = MockHelper.CreateSearchMediator(new GetSearchResponse(TestDataHelper.CreateAlbums(), It.IsAny<int>()));

            using(SearchController controller = new SearchController(fakeMediator.Object))
            {
                //Act
                OkObjectResult result = await controller.GetAlbums(It.IsAny<string>(),
                    It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>()).ConfigureAwait(false) as OkObjectResult;

                GetSearchResponse response = result.Value as GetSearchResponse;

                //Assert
                Assert.IsTrue(response.Response.Count > 0, "There are no albums.");
            }
        }

        [TestMethod]
        public async Task GetAlbumsShouldReturnResultOfTypeJsonResult()
        {
            //Arrange
            var fakeMediator = MockHelper.CreateSearchMediator(It.IsAny<GetSearchResponse>());

            using(SearchController controller = new SearchController(fakeMediator.Object))
            {
                //Act
                var result = await controller
                    .GetAlbums(It.IsAny<string>(), It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>())
                    .ConfigureAwait(false);

                //Assert
                Assert.IsInstanceOfType(result, typeof(OkObjectResult));
            }
        }
    }
}
