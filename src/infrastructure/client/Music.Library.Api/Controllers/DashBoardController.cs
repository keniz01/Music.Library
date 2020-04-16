using MediatR;
using Microsoft.AspNetCore.Mvc;
using Music.Library.Application.UseCases.DashBoard;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DashBoardController : Controller
    {
        private readonly IMediator _mediator;
        public DashBoardController(IMediator mediator) => _mediator = mediator;

        [Route("")]
        public async Task<IActionResult> Index(CancellationToken cancellationToken = default)
        {
            var albums = await _mediator
                .Send(new GetDashBoardRequest(), cancellationToken)
                .ConfigureAwait(false);

            return Ok(albums);
        }
    }
}