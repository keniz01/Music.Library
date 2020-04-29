using MediatR;
using Music.Library.Core.Entities;

namespace Music.Library.Application.UseCases.Search
{
    public class GetSearchRequest : Pagination, IRequest<SearchPackage>
    {
        public GetSearchRequest(string query, int pageNumber, int pageSize)
            : base(pageNumber, pageSize) => Query = query;

        public string Query { get; }
    }
}
