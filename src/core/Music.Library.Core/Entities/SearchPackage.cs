using System.Collections.Generic;

namespace Music.Library.Core.Entities
{
    public class SearchPackage
    {
        public SearchPackage() => Response = new List<Record>();

        public List<Record> Response { get; set; }
        public int ResponseCount { get; set; }
    }
}
