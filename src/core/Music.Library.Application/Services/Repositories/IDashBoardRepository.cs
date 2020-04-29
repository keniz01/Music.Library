using Music.Library.Application.Features.DashBoard;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Application.Services.Repositories
{
    public interface IDashBoardRepository
    {
        Task<GetDashBoardResponse> GetDashBoardAsync(CancellationToken cancellationToken);
    }
}
