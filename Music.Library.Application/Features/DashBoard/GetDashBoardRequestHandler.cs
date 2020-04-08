using MediatR;
using Music.Library.Application.Services.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Application.Features.DashBoard
{
    public class GetDashBoardRequestHandler : IRequestHandler<GetDashBoardRequest, GetDashBoardResponse>
    {
        private readonly IDashBoardRepository _repository;
        public GetDashBoardRequestHandler(IDashBoardRepository repository) => _repository = repository;

        public async Task<GetDashBoardResponse> Handle(GetDashBoardRequest request, CancellationToken cancellationToken) =>
            await _repository.GetDashBoardAsync(cancellationToken).ConfigureAwait(false);
    }
}
