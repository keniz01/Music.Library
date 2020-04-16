using System.Collections.Generic;

namespace Music.Library.Core.Entities
{
    public class DashBoardPackage
    {
        public DashBoardPackage(DashBoardMetrics metrics, List<Record> latestAlbums)
        {
            Metrics = metrics;
            LatestAlbums = latestAlbums;
        }

        public DashBoardMetrics Metrics { get; }
        public List<Record> LatestAlbums { get; }
    }
}
