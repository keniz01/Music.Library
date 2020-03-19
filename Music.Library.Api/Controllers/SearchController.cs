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

        [Route("")]
        public async Task<IActionResult> Index()
        {
            var latestTenAlbums = await _albumService.GetMostRecentTenAlbumsAsync();
            return Json(latestTenAlbums);
        }
    }
}