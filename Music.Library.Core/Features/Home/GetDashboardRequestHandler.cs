using MediatR;
using Music.Library.Core.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Core.Features.Home
{
    public class GetDashboardRequestHandler : IRequestHandler<GetDashboardRequest, GetDashboardResponse>
    {
        private readonly IDashboardRepository _repository;
        public GetDashboardRequestHandler(IDashboardRepository repository) => _repository = repository;

        public async Task<GetDashboardResponse> Handle(GetDashboardRequest request, CancellationToken cancellationToken) =>
            await _repository.GetDashboardAsync(cancellationToken).ConfigureAwait(false);
    }
}
