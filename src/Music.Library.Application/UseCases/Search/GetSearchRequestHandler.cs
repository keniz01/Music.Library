using MediatR;
using Music.Library.Core.Entities;
using Music.Library.Core.Services.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Application.UseCases.Search
{
    public class GetSearchRequestHandler : IRequestHandler<GetSearchRequest, SearchPackage>
    {
        private readonly ISearchRepository _searchRepository;
        public GetSearchRequestHandler(ISearchRepository searchRepository) => _searchRepository = searchRepository;

        public async Task<SearchPackage> Handle(GetSearchRequest request, CancellationToken cancellationToken) =>
            await _searchRepository.GetSearchResponseAsync(request.Query, request.PageNumber, request.PageSize, cancellationToken)
            .ConfigureAwait(false);
    }
}
