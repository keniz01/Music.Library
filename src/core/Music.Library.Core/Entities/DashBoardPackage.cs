using System.Collections.Generic;

namespace Music.Library.Core.Entities
{
    public class DashBoardPackage
    {
        public DashBoardPackage() => LatestAlbums = new List<Record>();

        public DashBoardMetrics Metrics { get; set; }
        public List<Record> LatestAlbums { get; set; }
    }
}
