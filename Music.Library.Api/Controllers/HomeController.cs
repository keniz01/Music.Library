using MediatR;
using Microsoft.AspNetCore.Mvc;
using Music.Library.Core.Features.Home;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HomeController : Controller
    {
        private readonly IMediator _mediator;
        public HomeController(IMediator mediator) => _mediator = mediator;

        [Route("")]
        public async Task<IActionResult> Index(CancellationToken cancellationToken = default)
        {
            var albums = await _mediator
                .Send(new GetDashboardRequest(), cancellationToken)
                .ConfigureAwait(false);

            return Ok(albums);
        }
    }
}