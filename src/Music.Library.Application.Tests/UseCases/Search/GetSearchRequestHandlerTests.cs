using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Music.Library.Application.Tests.Common;
using Music.Library.Application.UseCases.Search;
using Music.Library.Core.Entities;
using Music.Library.Core.Services.Repositories;
using System.Threading.Tasks;

namespace Music.Library.Api.Tests.UseCases.Search
{
    [TestClass]
    public class GetSearchRequestHandlerTests
    {
        private SearchPackage _searchPackage;

        [TestInitialize]
        public async Task SetUp()
        {
            var mediator = new Mock<ISearchRepository>(MockBehavior.Strict);
            mediator.Setup(m => m.GetSearchResponseAsync(It.IsAny<string>(), It.IsAny<int>(), It.IsAny<int>(), default))
                .ReturnsAsync(new SearchPackage(TestData.Albums(), 1000));

            var searchRequestHandler = new GetSearchRequestHandler(mediator.Object);

            _searchPackage = await searchRequestHandler
                .Handle(new GetSearchRequest(It.IsAny<string>(), It.IsAny<int>(), It.IsAny<int>()), default)
                .ConfigureAwait(false);
        }

        [TestMethod]
        public void GetSearchRequestHandler_ReturnsSearchResponseCount() =>
            //Assert
            Assert.IsTrue(_searchPackage.ResponseCount == 1000, "The search response count is invalid.");

        [TestMethod]
        public void GetSearchRequestHandler_ReturnsAListOfAtleastOneAlbum() =>
            //Assert
            Assert.IsTrue(_searchPackage.Response.Count > 0, "There are no albums.");

        [TestMethod]
        public void GetSearchRequestHandler_ReturnsResultOfTypeSearchPackage() =>
            //Assert
            Assert.IsInstanceOfType(_searchPackage, typeof(SearchPackage));
    }
}
