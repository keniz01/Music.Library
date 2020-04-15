using Music.Library.Core.Entities;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Core.Services.Repositories
{
    public interface ISearchRepository
    {
        Task<SearchPackage> GetSearchResponseAsync(string query, int pageNumber, int pageSize, CancellationToken cancellationToken);
    }
}
