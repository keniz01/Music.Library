using Music.Library.Core.Models;

namespace Music.Library.Core.Features.Home
{
    public class GetStatisticsResponse
    { 
        public GetStatisticsResponse(GetStatisticsResult statistics) => Statistics = statistics;

        public GetStatisticsResult Statistics { get; }
    }
}
