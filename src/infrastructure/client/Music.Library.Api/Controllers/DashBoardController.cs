// <copyright file="DashBoardController.cs" company="PlaceholderCompany">
// Copyright (c) PlaceholderCompany. All rights reserved.
// </copyright>

using MediatR;
using Microsoft.AspNetCore.Mvc;
using Music.Library.Application.UseCases.DashBoard;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Api.Controllers
{
    /// <summary>
    /// Dash board controller.
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    public class DashBoardController : Controller
    {
        private readonly IMediator _mediator;

        /// <summary>
        /// Initializes a new instance of the <see cref="DashBoardController"/> class.
        /// </summary>
        /// <param name="mediator">The mediator.</param>
        public DashBoardController(IMediator mediator) => _mediator = mediator;

        /// <summary>
        /// Get dash board details.
        /// </summary>
        /// <param name="cancellationToken">The cancellation token.</param>
        /// <returns>A <see cref="Task{TResult}"/> representing the result of the asynchronous operation.</returns>
        [HttpGet("")]
        public async Task<IActionResult> GetDashboardDetailsAsync(CancellationToken cancellationToken = default)
        {
            var albums = await _mediator
                .Send(new GetDashBoardRequest(), cancellationToken)
                .ConfigureAwait(false);

            return Ok(albums);
        }
    }
}