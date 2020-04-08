using MediatR;

namespace Music.Library.Application.Features.Search
{
    public class GetSearchRequest : Pagination, IRequest<GetSearchResponse>
    {
        public GetSearchRequest(string query, int pageNumber, int pageSize)
            : base(pageNumber, pageSize) => Query = query;

        public string Query { get; }
    }
}
