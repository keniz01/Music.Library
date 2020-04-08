using Music.Library.Core.Entities;
using System.Collections.Generic;

namespace Music.Library.Application.Features.Search
{
    public class GetSearchResponse
    {
        public GetSearchResponse(List<SearchResponse> response, int responseCount)
        {
            Response = response;
            ResponseCount = responseCount;
        }

        public List<SearchResponse> Response { get; }
        public int ResponseCount { get; }
    }
}
