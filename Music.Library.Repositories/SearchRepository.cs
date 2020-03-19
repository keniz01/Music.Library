using Music.Library.Core.Features.FindAlbums;
using Music.Library.Core.Repositories;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Music.Library.Repositories
{
    public class SearchRepository : ISearchRepository
    {
        public Task<List<FindAlbumResponse>> FindAlbumsAsync(string query)
        {
            throw new System.NotImplementedException();
        }
    }
}
