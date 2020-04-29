// <copyright file="DashBoardControllerUnitTests.cs" company="PlaceholderCompany">
// Copyright (c) PlaceholderCompany. All rights reserved.
// </copyright>

using Microsoft.VisualStudio.TestTools.UnitTesting;
using Music.Library.Api.Integration.Tests.Common;
using Music.Library.Core.Entities;
using System.Threading.Tasks;

namespace Music.Library.Api.Integration.Tests.UseCases.DashBoard
{
    [TestClass]
    public class DashBoardControllerTests: IntegrationTestBase
    {
        [TestMethod]
        public async Task GetDashboardResponse_ShouldReturnListOfRecords()
        {
            var result = await GetAsync<DashBoardPackage>("/api/dashboard").ConfigureAwait(false);
            Assert.IsTrue(result.LatestAlbums.Count > 0, "There are no albums.");
        }

        [TestMethod]
        public async Task GetDashboardResponse_ShouldReturnNoneNullBoardMetricDetailsObject()
        {
            var result = await GetAsync<DashBoardPackage>("/api/dashboard").ConfigureAwait(false);

            Assert.IsNotNull(result.Metrics, "Metrics do not match dummy data.");
        }

        [TestMethod]
        public async Task GetDashboardResponse_ShouldReturnObjectOfTypeDashBoardMetrics()
        {
            var result = await GetAsync<DashBoardPackage>("/api/dashboard").ConfigureAwait(false);
            Assert.IsInstanceOfType(result.Metrics, typeof(DashBoardMetrics));
        }
    }
}
