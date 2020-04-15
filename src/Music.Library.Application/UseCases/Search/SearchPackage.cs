using Music.Library.Core.Entities;
using System.Collections.Generic;

namespace Music.Library.Application.Features.Search
{
    public class SearchPackage
    {
        public SearchPackage(List<Album> response, int responseCount)
        {
            Response = response;
            ResponseCount = responseCount;
        }

        public List<Album> Response { get; }
        public int ResponseCount { get; }
    }
}
