using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Music.Library.Application.Tests.Common;
using Music.Library.Application.UseCases.DashBoard;
using Music.Library.Core.Entities;
using Music.Library.Core.Services.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Api.Tests.UseCases.DashBoard
{
    [TestClass]
    public class GetDashBoardRequestHandlerTests
    {
        private DashBoardPackage _dashBoardPackage;

        [TestInitialize]
        public async Task SetUp()
        {
            var mediator = new Mock<IDashBoardRepository>(MockBehavior.Strict);
            mediator.Setup(m => m.GetDashBoardAsync(It.IsAny<CancellationToken>()))
                .ReturnsAsync(new DashBoardPackage(TestData.Metrics(), TestData.Albums()));

            var handler = new GetDashBoardRequestHandler(mediator.Object);

            _dashBoardPackage = await handler
                .Handle(It.IsAny<GetDashBoardRequest>(), default)
                .ConfigureAwait(false);
        }

        [TestMethod]
        public void GetDashBoardRequestHandler_ReturnsAListOfAtleastOneAlbum() =>
            //Assert
            Assert.IsTrue(_dashBoardPackage.LatestAlbums.Count > 0, "There are no albums.");

        [TestMethod]
        public void GetDashBoardRequestHandler_MetricShouldNotRetainSuppliedValues()
        {
            //Act
            var success = _dashBoardPackage.Metrics.TotalRecords == 1000 &&
                _dashBoardPackage.Metrics.TotalAlbums == 150 &&
                _dashBoardPackage.Metrics.TotalGenres == 10 &&
                _dashBoardPackage.Metrics.TotalLabels == 8 &&
                _dashBoardPackage.Metrics.TotalArtists == 90;

            //Assert
            Assert.IsTrue(success, "Metrics do not match dummy data.");
        }

        [TestMethod]
        public void GetDashBoardRequestHandler_ReturnsResultOfTypeDashBoardPackage() =>
            //Assert
            Assert.IsInstanceOfType(_dashBoardPackage, typeof(DashBoardPackage));
    }
}
