using Music.Library.Core.Features.Search;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Core.Repositories
{
    public interface ISearchRepository
    {
        Task<GetAlbumsResponse> GetAlbumsAsync(string query, int pageNumber, int pageSize, CancellationToken cancellationToken);
    }
}
