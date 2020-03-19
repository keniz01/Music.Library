using Microsoft.AspNetCore.Mvc;
using Music.Library.Core.Services;
using System.Threading.Tasks;

namespace Music.Library.Api.Controllers
{
    [ApiController]
    [Route("{controller}")]
    public class SearchController : Controller
    {
        private readonly IAlbumService _albumService;
        public SearchController(IAlbumService albumService)
        {
            _albumService = albumService;
        }

        [Route("{query}")]
        public async Task<IActionResult> FindAlbums(string query)
        {
            var albums = await _albumService.FindAlbumsAsync(query).ConfigureAwait(false);
            return Json(albums);
        }
    }
}