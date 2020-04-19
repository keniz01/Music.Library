// <copyright file="DashBoardControllerUnitTests.cs" company="PlaceholderCompany">
// Copyright (c) PlaceholderCompany. All rights reserved.
// </copyright>

using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Music.Library.Api.Controllers;
using Music.Library.Api.Unit.Tests.Common;
using Music.Library.Core.Entities;
using Music.Library.Tests.Common;
using System.Threading.Tasks;

namespace Music.Library.Api.Unit.Tests.UseCases.DashBoard
{
    [TestClass]
    public class DashBoardControllerUnitTests : DisposableTestBase
    {
        private DashBoardController _dashBoardController;

        [TestInitialize]
        public void SetUp()
        {
            var response = new DashBoardPackage
            {
                Metrics = TestData.CreateMetrics(),
                LatestAlbums = TestData.CreateAlbums()
            };

            var mediator = MoqFactory.MockDashboardMediator(response);
            _dashBoardController = new DashBoardController(mediator.Object);
            RegisterForDispose(_dashBoardController);
        }

        [TestMethod]
        public async Task GetDashBoardShouldReturnAListOfAtleastOneAlbum()
        {
            var response = (await _dashBoardController.GetDashboardDetails().ConfigureAwait(false) as OkObjectResult)?.Value as DashBoardPackage;

            Assert.IsTrue(response.LatestAlbums.Count > 0, "There are no albums.");
        }

        [TestMethod]
        public async Task DashboardMetrics()
        {
            var response = (await _dashBoardController.GetDashboardDetails().ConfigureAwait(false) as OkObjectResult)?.Value as DashBoardPackage;

            var success = response.Metrics.TotalRecords == 1000 && response.Metrics.TotalAlbums == 150 &&
                response.Metrics.TotalGenres == 10 && response.Metrics.TotalLabels == 8 && response.Metrics.TotalArtists == 90;

            Assert.IsTrue(success, "Metrics do not match dummy data.");
        }

        [TestMethod]
        public async Task GetDashboardShouldReturnResultOfTypeJsonResult()
        {
            var result = await _dashBoardController.GetDashboardDetails().ConfigureAwait(false) as OkObjectResult;
            Assert.IsInstanceOfType(result, typeof(OkObjectResult));
        }

        [TestCleanup]
        public void TearDown() => Dispose();
    }
}
