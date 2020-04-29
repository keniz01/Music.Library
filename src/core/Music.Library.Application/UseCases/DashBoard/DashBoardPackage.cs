using Music.Library.Core.Entities;
using System.Collections.Generic;

namespace Music.Library.Application.Features.DashBoard
{
    public class DashBoardPackage
    {
        public DashBoardPackage(DashBoardMetrics metrics, List<Album> latestAlbums)
        {
            Metrics = metrics;
            LatestAlbums = latestAlbums;
        }

        public DashBoardMetrics Metrics { get; }
        public List<Album> LatestAlbums{ get; }
    }
}
