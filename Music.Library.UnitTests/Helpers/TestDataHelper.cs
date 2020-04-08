using Music.Library.Core.Entities;
using System.Collections.Generic;

namespace Music.Library.UnitTests.Helpers
{
    public static class TestDataHelper
    {
        public static List<SearchResponse> CreateAlbums() => new List<SearchResponse>
            {
                new SearchResponse( 1, "Beenie Man", null, null, "The Doctor", null, null, null),
                new SearchResponse( 2, "Bob Marley", null, null, "Soul Rebel", null, null, null),
                new SearchResponse( 3, "Bob Marley", null, null, "Soul Revolution", null, null, null),
                new SearchResponse( 4, "Bob Marley", null, null, "Catch A Fire", null, null, null)
            };

        public static DashBoardMetrics CreateMetrics() => new DashBoardMetrics(1000, 150, 10, 8, 90);
    }
}
