using Music.Library.Core.Models;
using System.Collections.Generic;

namespace Music.Library.Core.Features.FindAlbums
{
    public class FindAlbumResponse
    {
        public FindAlbumResponse(List<FindAlbumsData> albums)
        {
            Albums = albums;
        }

        public List<FindAlbumsData> Albums { get; }
    }
}
