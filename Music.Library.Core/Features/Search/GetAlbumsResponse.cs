using Music.Library.Core.Models;
using System.Collections.Generic;

namespace Music.Library.Core.Features.Search
{
    public class GetAlbumsResponse
    {
        public GetAlbumsResponse(List<GetAlbumResult> albums) => Albums = albums;

        public List<GetAlbumResult> Albums { get; }
    }
}
