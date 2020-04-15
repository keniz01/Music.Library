using MediatR;
using Music.Library.Core.Entities;
using Music.Library.Core.Services.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Application.UseCases.DashBoard
{
    public class GetDashBoardRequestHandler : IRequestHandler<GetDashBoardRequest, DashBoardPackage>
    {
        private readonly IDashBoardRepository _repository;
        public GetDashBoardRequestHandler(IDashBoardRepository repository) => _repository = repository;

        public async Task<DashBoardPackage> Handle(GetDashBoardRequest request, CancellationToken cancellationToken) =>
            await _repository.GetDashBoardAsync(cancellationToken).ConfigureAwait(false);
    }
}
