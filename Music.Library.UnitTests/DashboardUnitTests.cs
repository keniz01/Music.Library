using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Music.Library.Api.Controllers;
using Music.Library.Core.Features.Home;
using Music.Library.Core.Features.Search;
using Music.Library.UnitTests.Helpers;
using System.Threading.Tasks;

namespace Music.Library.UnitTests
{
    [TestClass]
    public class DashboardUnitTests
    {
        [TestMethod]
        public async Task GetDashboardShouldReturnAListOfAtleastOneAlbum()
        {
            //Arrange
            var fakeMediator = MockHelper.CreateDashboardMediator(
                new GetDashboardResponse(TestDataHelper.CreateStatistics(), TestDataHelper.CreateAlbums()));

            using(var controller = new HomeController(fakeMediator.Object))
            {
                //Act
                var result = await controller.Index().ConfigureAwait(false) as OkObjectResult;
                var response = result.Value as GetDashboardResponse;

                //Assert
                Assert.IsTrue(response.Albums.Count > 0, "There are no albums.");
            }
        }

        [TestMethod]
        public async Task GetDashboardShouldReturnDashboardStatistics()
        {
            //Arrange
            var fakeMediator = MockHelper.CreateDashboardMediator(
                new GetDashboardResponse(TestDataHelper.CreateStatistics(), TestDataHelper.CreateAlbums()));

            using(var controller = new HomeController(fakeMediator.Object))
            {
                //Act
                var result = await controller.Index().ConfigureAwait(false) as OkObjectResult;
                var response = result.Value as GetDashboardResponse;

                //Assert
                Assert.IsTrue(response.Statistics.TotalRecords == 1000, 
                    "Wrong total number of records.");
            }
        }

        [TestMethod]
        public async Task GetDashboardShouldReturnResultOfTypeJsonResult()
        {
            //Arrange
            var fakeMediator = MockHelper.CreateDashboardMediator(
                new GetDashboardResponse(TestDataHelper.CreateStatistics(), TestDataHelper.CreateAlbums()));

            using(var controller = new HomeController(fakeMediator.Object))
            {
                //Act
                var result = await controller.Index().ConfigureAwait(false) as OkObjectResult;

                //Assert
                Assert.IsInstanceOfType(result, typeof(OkObjectResult));
            }
        }
    }
}
