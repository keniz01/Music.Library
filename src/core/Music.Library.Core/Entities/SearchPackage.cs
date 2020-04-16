using System.Collections.Generic;

namespace Music.Library.Core.Entities
{
    public class SearchPackage
    {
        public SearchPackage(List<Record> response, int responseCount)
        {
            Response = response;
            ResponseCount = responseCount;
        }

        public List<Record> Response { get; }
        public int ResponseCount { get; }
    }
}
