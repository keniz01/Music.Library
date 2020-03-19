using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Music.Library.Api.Controllers;
using Music.Library.Core.Features.FindAlbums;
using Music.Library.Core.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Music.Library.UnitTests
{
    [TestClass]
    public class SearchUnitTests
    {
        [TestMethod]
        public async Task FindAlbums_Should_return_a_list_of_atleast_one_albums()
        {
            var artist = new Artist { Id = 1, Name = "Beenie Man" };
            var album = new Album { Id = 1, Title = "The Doctor", YearReleased = 2003, RecordCount = 12 };
            var genres = new List<Genre> { new Genre { Id = 1, Name = "Reggae" } };
            var labels = new List<Label> { new Label { Id = 1, Name = "VP Records" } };

            //Arrange
            var albums = new List<FindAlbumResponse>
            {
                new FindAlbumResponse(artist, album, labels, genres)
            };

            var fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<FindAlbumRequest>(), default))
                .ReturnsAsync(albums);

            SearchController controller = new SearchController(fakeMediator.Object);

            //Act
            var result = (await controller.FindAlbums(It.IsAny<string>())
                .ConfigureAwait(false) as JsonResult).Value as List<FindAlbumResponse>;

            //Assert
            Assert.IsTrue(result.Count > 0, "There are no albums.");
        }

        [TestMethod]
        public async Task FindAlbums_Should_return_result_of_type_JsonResult()
        {
            //Arrange
            var fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<FindAlbumRequest>(), default))
                .ReturnsAsync(It.IsAny<List<FindAlbumResponse>>);

            SearchController controller = new SearchController(fakeMediator.Object);

            //Act
            var result = await controller.FindAlbums(It.IsAny<string>()).ConfigureAwait(false);

            //Assert
            Assert.IsInstanceOfType(result, typeof(JsonResult));
        }
    }
}
