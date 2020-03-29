using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Music.Library.Api.Controllers;
using Music.Library.Core.Features.Search;
using Music.Library.Core.Models;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.UnitTests
{
    [TestClass]
    public class SearchUnitTests
    {
        [TestMethod]
        public async Task GetAlbumsShouldReturnAListOfAtleastOneAlbums()
        {
            //Arrange
            List<GetAlbumResult> albums = new List<GetAlbumResult>
            {
                new GetAlbumResult( 1, "Beenie Man", null, null, "The Doctor", null, null, null),
                new GetAlbumResult( 1, "Bob Marley", null, null, "Soul Rebel", null, null, null),
                new GetAlbumResult( 1, "Bob Marley", null, null, "Soul Revolution", null, null, null),
                new GetAlbumResult( 1, "Bob Marley", null, null, "Catch A Fire", null, null, null)
            };

            Mock<IMediator> fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<GetAlbumsRequest>(), default))
                .ReturnsAsync(new GetAlbumsResponse(albums));

            using(SearchController controller = new SearchController(fakeMediator.Object))
            {
                //Act
                OkObjectResult result = await controller
                    .FindAlbums
                    (
                        It.IsAny<string>(),
                        It.IsAny<int>(),
                        It.IsAny<int>(),
                        It.IsAny<CancellationToken>()
                    )
                    .ConfigureAwait(false) as OkObjectResult;
                GetAlbumsResponse response = result.Value as GetAlbumsResponse;

                //Assert
                Assert.IsTrue(response.Albums.Count > 0, "There are no albums.");
            }
        }

        [TestMethod]
        public async Task GetAlbumsShouldReturnResultOfTypeJsonResult()
        {
            //Arrange
            Mock<IMediator> fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<GetAlbumsRequest>(), default))
                .ReturnsAsync(It.IsAny<GetAlbumsResponse>);

            using(SearchController controller = new SearchController(fakeMediator.Object))
            {
                //Act
                IActionResult result = await controller
                    .FindAlbums
                    (
                        It.IsAny<string>(),
                        It.IsAny<int>(),
                        It.IsAny<int>(),
                        It.IsAny<CancellationToken>()
                    )
                    .ConfigureAwait(false);

                //Assert
                Assert.IsInstanceOfType(result, typeof(OkObjectResult));
            }
        }
    }
}
