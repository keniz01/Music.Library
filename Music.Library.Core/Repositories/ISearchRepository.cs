using Music.Library.Core.Features.FindAlbums;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Music.Library.Core.Repositories
{
    public interface ISearchRepository
    {
        Task<List<FindAlbumResponse>> FindAlbumsAsync(string query);
    }
}
