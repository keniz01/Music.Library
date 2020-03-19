using Music.Library.Core.Models;
using Music.Library.Core.Services;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Music.Library.Services
{
    public class AlbumService : IAlbumService
    {
        /// <summary>
        /// Gets the most recent 10 albums.
        /// </summary>
        /// <param name="query">The search query.</param>
        /// <returns>A list of 10 albums</returns>
        public Task<List<AlbumResult>> FindAlbumsAsync(string query)
        {
            throw new NotImplementedException();
        }
    }
}
