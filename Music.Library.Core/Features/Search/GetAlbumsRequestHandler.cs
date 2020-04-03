using MediatR;
using Music.Library.Core.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Core.Features.Search
{
    public class GetAlbumsRequestHandler : IRequestHandler<GetAlbumsRequest, GetAlbumsResponse>
    {
        private readonly ISearchRepository _searchRepository;
        public GetAlbumsRequestHandler(ISearchRepository searchRepository) => _searchRepository = searchRepository;

        public async Task<GetAlbumsResponse> Handle(GetAlbumsRequest request, CancellationToken cancellationToken) =>
            await _searchRepository.GetAlbumsAsync(request.Query, request.PageNumber, request.PageSize, cancellationToken);
    }
}
