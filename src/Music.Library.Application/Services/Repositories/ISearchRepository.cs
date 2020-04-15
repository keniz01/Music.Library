using Music.Library.Application.Features.Search;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Application.Services.Repositories
{
    public interface ISearchRepository
    {
        Task<GetSearchResponse> GetSearchResponseAsync(string query, int pageNumber, int pageSize, CancellationToken cancellationToken);
    }
}
