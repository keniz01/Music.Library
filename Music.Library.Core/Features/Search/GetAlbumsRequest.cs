using MediatR;

namespace Music.Library.Core.Features.Search
{
    public class GetAlbumsRequest : IRequest<GetAlbumsResponse>
    {
        public GetAlbumsRequest(string query, int pageNumber, int pageSize)
        {
            Query = query;
            PageSize = pageSize;
            PageNumber = pageNumber;
        }

        public string Query { get; }
        public int PageSize { get; }
        public int PageNumber { get; }
    }
}
