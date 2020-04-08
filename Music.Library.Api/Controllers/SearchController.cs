using MediatR;
using Microsoft.AspNetCore.Mvc;
using Music.Library.Application.Features.Search;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SearchController : Controller
    {
        private readonly IMediator _mediator;
        public SearchController(IMediator mediator) => _mediator = mediator;

        [Route("{query}/{pageNumber}/{pageSize}")]
        public async Task<IActionResult> GetAlbums(string query, int pageNumber = 1, int pageSize = 10, CancellationToken cancellationToken = default)
        {
            var albums = await _mediator
                .Send(new GetSearchRequest(query, pageNumber, pageSize), cancellationToken)
                .ConfigureAwait(false);

            return Ok(albums);
        }
    }
}