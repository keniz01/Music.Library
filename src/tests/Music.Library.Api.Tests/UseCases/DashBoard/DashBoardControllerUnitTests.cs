using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Music.Library.Api.Controllers;
using Music.Library.Api.Tests.Common;
using Music.Library.Core.Entities;
using System.Threading.Tasks;

namespace Music.Library.Api.Tests.UseCases.DashBoard
{
    [TestClass]
    public class DashBoardControllerUnitTests : DisposableTestBase
    {
        private DashBoardController _dashBoardController;

        [TestInitialize]
        public void SetUp()
        {
            var response = new DashBoardPackage(TestData.CreateMetrics(), TestData.CreateAlbums());
            var mediator = MoqFactory.MockDashboardMediator(response);
            _dashBoardController = new DashBoardController(mediator.Object);
            RegisterForDispose(_dashBoardController);
        }

        [TestMethod]
        public async Task GetDashBoardShouldReturnAListOfAtleastOneAlbum()
        {
            //Act
            var response = (await _dashBoardController.Index().ConfigureAwait(false) as OkObjectResult)?.Value as DashBoardPackage;

            //Assert
            Assert.IsTrue(response.LatestAlbums.Count > 0, "There are no albums.");
        }

        [TestMethod]
        public async Task DashboardMetrics()
        {
            //Act
            var response = (await _dashBoardController.Index().ConfigureAwait(false) as OkObjectResult)?.Value as DashBoardPackage;

            var success = response.Metrics.TotalRecords == 1000 && response.Metrics.TotalAlbums == 150 &&
                response.Metrics.TotalGenres == 10 && response.Metrics.TotalLabels == 8 && response.Metrics.TotalArtists == 90;

            //Assert
            Assert.IsTrue(success, "Metrics do not match dummy data.");
        }

        [TestMethod]
        public async Task GetDashboardShouldReturnResultOfTypeJsonResult()
        {
            //Act
            var result = await _dashBoardController.Index().ConfigureAwait(false) as OkObjectResult;

            //Assert
            Assert.IsInstanceOfType(result, typeof(OkObjectResult));
        }

        [TestCleanup]
        public void TearDown() => Dispose();
    }
}
