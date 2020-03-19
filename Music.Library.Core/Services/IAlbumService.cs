using Music.Library.Core.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Music.Library.Core.Services
{
    public interface IAlbumService
    {
        /// <summary>
        /// Gets the most recent 10 albums.
        /// </summary>
        /// <param name="query">The search string.</param>
        /// <returns>A list of 10 albums</returns>
        Task<List<AlbumResult>> FindAlbumsAsync(string query);
    }
}
