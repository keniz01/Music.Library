using Moq;
using Music.Library.Core.Models;
using Music.Library.Core.Services;
using System.Collections.Generic;

namespace Music.Library.UnitTests.Helpers.Mocks
{
    public static class MockAlbumService
    {
        public static IAlbumService Create(List<AlbumResult> returnValue, string query)
        {
            var mock = new Mock<IAlbumService>(MockBehavior.Strict);
            mock.Setup(service => service.FindAlbumsAsync(query))
                .ReturnsAsync(returnValue);

            return mock.Object;
        }
    }
}
