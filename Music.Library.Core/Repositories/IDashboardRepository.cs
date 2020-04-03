using Music.Library.Core.Features.Home;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Core.Repositories
{
    public interface IDashboardRepository
    {
        Task<GetDashboardResponse> GetDashboardAsync(CancellationToken cancellationToken);
    }
}
