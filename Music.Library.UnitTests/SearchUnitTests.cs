using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Music.Library.Api.Controllers;
using Music.Library.Core.Models;
using Music.Library.Core.Services;
using Music.Library.Services;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Music.Library.UnitTests
{
    [TestClass]
    public class SearchUnitTests
    {
        [TestMethod]
        public async Task GetLastestTenAlbums_Should_return_result_of_type_JsonResult()
        {
            //Arrange
            var albums = new List<AlbumResult>
            {
                new AlbumResult()
            };

            var mockAlbumService = new Mock<IAlbumService>(MockBehavior.Strict);
            mockAlbumService.Setup(service => service.GetMostRecentTenAlbumsAsync())
                .ReturnsAsync(albums);

            SearchController controller = new SearchController(mockAlbumService.Object);

            //Act
            var result = await controller.Index();

            //Assert
            Assert.IsInstanceOfType(result, typeof(JsonResult));
        }
    }
}
