using Music.Library.Core.Features.FindAlbums;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Core.Repositories
{
    public interface ISearchRepository
    {
        Task<FindAlbumResponse> FindAlbumsAsync(string query, int pageNumber, int pageSize, CancellationToken cancellationToken);
    }
}
