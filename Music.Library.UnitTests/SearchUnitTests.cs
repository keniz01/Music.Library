using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Music.Library.Api.Controllers;
using Music.Library.Core.Features.FindAlbums;
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
        public async Task FindAlbums_Should_return_a_list_of_atleast_one_albums()
        {
            //Arrange
            var albums = new List<FindAlbumsData>
            {
                new FindAlbumsData{ AlbumId = 1, ArtistName = "Beenie Man", Title = "The Doctor" },
                new FindAlbumsData{ AlbumId = 2, ArtistName = "Bob Marley", Title = "Soul Rebel" },
                new FindAlbumsData{ AlbumId = 3, ArtistName = "Bob Marley", Title = "Soul Revolution" },
                new FindAlbumsData{ AlbumId = 4, ArtistName = "Bob Marley", Title = "Catch A Fire" }
            };

            var fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<FindAlbumRequest>(), default))
                .ReturnsAsync(new FindAlbumResponse(albums));

            SearchController controller = new SearchController(fakeMediator.Object);

            //Act
            var result = await controller
                .FindAlbums
                (
                    It.IsAny<string>(),
                    It.IsAny<int>(),
                    It.IsAny<int>(),
                    It.IsAny<CancellationToken>()
                )
                .ConfigureAwait(false) as OkObjectResult;
            var response = result.Value as FindAlbumResponse;

            //Assert
            Assert.IsTrue(response.Albums.Count > 0, "There are no albums.");
        }

        [TestMethod]
        public async Task FindAlbums_Should_return_result_of_type_JsonResult()
        {
            //Arrange
            var fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<FindAlbumRequest>(), default))
                .ReturnsAsync(It.IsAny<FindAlbumResponse>);

            SearchController controller = new SearchController(fakeMediator.Object);

            //Act
            var result = await controller
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
