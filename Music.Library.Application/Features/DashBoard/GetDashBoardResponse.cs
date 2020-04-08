using Music.Library.Core.Entities;
using System.Collections.Generic;

namespace Music.Library.Application.Features.DashBoard
{
    public class GetDashBoardResponse
    {
        public GetDashBoardResponse(DashBoardMetrics metrics, List<SearchResponse> latestAlbums)
        {
            Metrics = metrics;
            LatestAlbums = latestAlbums;
        }

        public DashBoardMetrics Metrics { get; }
        public List<SearchResponse> LatestAlbums{ get; }
    }
}
