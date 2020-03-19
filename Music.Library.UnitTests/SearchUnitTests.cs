using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Music.Library.Api.Controllers;
using Music.Library.Core.Models;
using Music.Library.UnitTests.Helpers.Mocks;
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
            //Arrange
            var albums = new List<AlbumResult>
            {
                new AlbumResult
                {
                    Artist = new Artist { Id = 1, Name = "Beenie Man" },
                    Album = new Album { Id = 1, Title = "The Doctor", YearReleased = 2003, RecordCount = 12 },
                    Genres = new List<Genre> { new Genre { Id = 1, Name = "Reggae"} },
                    Labels = new List<Label> { new Label { Id = 1, Name = "VP Records"} }
                }
            };

            var fakeService = MockAlbumService.Create(albums, It.IsAny<string>());
            SearchController controller = new SearchController(fakeService);

            //Act
            var result = (await controller.FindAlbums(It.IsAny<string>()).ConfigureAwait(false) as JsonResult).Value as List<AlbumResult>;

            //Assert
            Assert.IsTrue(result.Count > 0, "There are no albums.");
        }

        [TestMethod]
        public async Task FindAlbums_Should_return_result_of_type_JsonResult()
        {
            //Arrange
            var fakeService = MockAlbumService.Create(It.IsAny<List<AlbumResult>>(), It.IsAny<string>());
            SearchController controller = new SearchController(fakeService);

            //Act
            var result = await controller.FindAlbums(It.IsAny<string>()).ConfigureAwait(false);

            //Assert
            Assert.IsInstanceOfType(result, typeof(JsonResult));
        }
    }
}
