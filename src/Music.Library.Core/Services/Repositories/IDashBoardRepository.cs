using Music.Library.Core.Entities;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Core.Services.Repositories
{
    public interface IDashBoardRepository
    {
        Task<DashBoardPackage> GetDashBoardAsync(CancellationToken cancellationToken);
    }
}
