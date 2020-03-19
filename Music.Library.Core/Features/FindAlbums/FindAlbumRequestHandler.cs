using MediatR;
using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Core.Features.FindAlbums
{
    public class FindAlbumRequestHandler : IRequestHandler<FindAlbumRequest, List<FindAlbumResponse>>
    {
        public async Task<List<FindAlbumResponse>> Handle(FindAlbumRequest request, CancellationToken cancellationToken)
        {
            //Fake data.
            //Filter fake data.
            throw new NotImplementedException();
        }
    }
}
