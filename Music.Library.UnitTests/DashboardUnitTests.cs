using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Music.Library.Api.Controllers;
using Music.Library.Application.Features.DashBoard;
using Music.Library.UnitTests.Helpers;
using System.Threading.Tasks;

namespace Music.Library.UnitTests
{
    [TestClass]
    public class DashboardUnitTests
    {
        [TestMethod]
        public async Task GetDashBoardShouldReturnAListOfAtleastOneAlbum()
        {
            //Arrange
            var fakeMediator = MockHelper.CreateDashboardMediator(
                new GetDashBoardResponse(TestDataHelper.CreateMetrics(), TestDataHelper.CreateAlbums()));

            using(var controller = new DashBoardController(fakeMediator.Object))
            {
                //Act
                var result = await controller.Index().ConfigureAwait(false) as OkObjectResult;
                var response = result.Value as GetDashBoardResponse;

                //Assert
                Assert.IsTrue(response.LatestAlbums.Count > 0, "There are no albums.");
            }
        }

        [TestMethod]
        public async Task GetDashboardShouldReturnDashboardStatistics()
        {
            //Arrange
            var fakeMediator = MockHelper.CreateDashboardMediator(
                new GetDashBoardResponse(TestDataHelper.CreateMetrics(), TestDataHelper.CreateAlbums()));

            using(var controller = new DashBoardController(fakeMediator.Object))
            {
                //Act
                var result = await controller.Index().ConfigureAwait(false) as OkObjectResult;
                var response = result.Value as GetDashBoardResponse;

                //Assert
                Assert.IsTrue(response.Metrics.TotalRecords == 1000, 
                    "Wrong total number of records.");
            }
        }

        [TestMethod]
        public async Task GetDashboardShouldReturnResultOfTypeJsonResult()
        {
            //Arrange
            var fakeMediator = MockHelper.CreateDashboardMediator(
                new GetDashBoardResponse(TestDataHelper.CreateMetrics(), TestDataHelper.CreateAlbums()));

            using(var controller = new DashBoardController(fakeMediator.Object))
            {
                //Act
                var result = await controller.Index().ConfigureAwait(false) as OkObjectResult;

                //Assert
                Assert.IsInstanceOfType(result, typeof(OkObjectResult));
            }
        }
    }
}
