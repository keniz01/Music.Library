using MediatR;
using System.Collections.Generic;

namespace Music.Library.Core.Features.FindAlbums
{
    public class FindAlbumRequest : IRequest<List<FindAlbumResponse>>
    {
        public FindAlbumRequest(string query)
        {
            Query = query;
        }

        public string Query { get; }
    }
}
