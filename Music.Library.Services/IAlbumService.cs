using Music.Library.Core.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Music.Library.Services
{
    public interface IAlbumService
    {
        /// <summary>
        /// Gets the most recent 10 albums.
        /// </summary>
        /// <returns>A list of 10 albums</returns>
        Task<List<AlbumResult>> GetMostRecentTenAlbumsAsync();
    }
}
