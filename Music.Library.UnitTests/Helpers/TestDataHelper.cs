using Music.Library.Core.Models;
using System.Collections.Generic;

namespace Music.Library.UnitTests.Helpers
{
    public static class TestDataHelper
    {
        public static List<GetAlbumResult> CreateAlbums() => new List<GetAlbumResult>
            {
                new GetAlbumResult( 1, "Beenie Man", null, null, "The Doctor", null, null, null),
                new GetAlbumResult( 2, "Bob Marley", null, null, "Soul Rebel", null, null, null),
                new GetAlbumResult( 3, "Bob Marley", null, null, "Soul Revolution", null, null, null),
                new GetAlbumResult( 4, "Bob Marley", null, null, "Catch A Fire", null, null, null)
            };

        public static GetStatisticsResult CreateStatistics() => new GetStatisticsResult(1000, 150, 10, 8, 90);
    }
}
