using Music.Library.Core.Models;
using System.Collections.Generic;

namespace Music.Library.Core.Features.Home
{
    public class GetDashboardResponse
    {
        public GetDashboardResponse(GetStatisticsResult statistics, List<GetAlbumResult> albums)
        {
            Statistics = statistics;
            Albums = albums;
        }

        public GetStatisticsResult Statistics { get; }
        public List<GetAlbumResult> Albums { get; }
    }
}
