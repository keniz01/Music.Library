using MediatR;
using Music.Library.Core.Entities;

namespace Music.Library.Application.UseCases.DashBoard
{
    public class GetDashBoardRequest : IRequest<DashBoardPackage>
    {
    }
}
