using MediatR;
using Music.Library.Application.Services.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Application.Features.Search
{
    public class GetSearchRequestHandler : IRequestHandler<GetSearchRequest, GetSearchResponse>
    {
        private readonly ISearchRepository _searchRepository;
        public GetSearchRequestHandler(ISearchRepository searchRepository) => _searchRepository = searchRepository;

        public async Task<GetSearchResponse> Handle(GetSearchRequest request, CancellationToken cancellationToken) =>
            await _searchRepository.GetSearchResponseAsync(request.Query, request.PageNumber, request.PageSize, cancellationToken);
    }
}
