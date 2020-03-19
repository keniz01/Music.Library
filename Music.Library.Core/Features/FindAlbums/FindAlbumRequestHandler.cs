using MediatR;
using Music.Library.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Core.Features.FindAlbums
{
    public class FindAlbumRequestHandler : IRequestHandler<FindAlbumRequest, List<FindAlbumResponse>>
    {
        private readonly ISearchRepository _searchRepository;
        public FindAlbumRequestHandler(ISearchRepository searchRepository)
        {
            _searchRepository = searchRepository;
        }

        public async Task<List<FindAlbumResponse>> Handle(FindAlbumRequest request, CancellationToken cancellationToken)
        {
            return await _searchRepository.FindAlbumsAsync(request.Query);
        }
    }
}
