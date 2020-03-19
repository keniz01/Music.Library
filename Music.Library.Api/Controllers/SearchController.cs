﻿using MediatR;
using Microsoft.AspNetCore.Mvc;
using Music.Library.Core.Features.FindAlbums;
using System.Threading.Tasks;

namespace Music.Library.Api.Controllers
{
    [ApiController]
    [Route("{controller}")]
    public class SearchController : Controller
    {
        private readonly IMediator _mediator;
        public SearchController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [Route("{query}")]
        public async Task<IActionResult> FindAlbums(string query)
        {
            var albums = await _mediator.Send(new FindAlbumRequest(query));
            return Json(albums);
        }
    }
}