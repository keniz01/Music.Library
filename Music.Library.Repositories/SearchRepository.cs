using Microsoft.EntityFrameworkCore;
using Music.Library.Core.Features.FindAlbums;
using Music.Library.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Repositories
{
    public class SearchRepository : ISearchRepository
    {
        private readonly MusicDataContext _context;
        public SearchRepository(MusicDataContext context)
        {
            _context = context;
        }

        public async Task<FindAlbumResponse> FindAlbumsAsync(string query, int pageNumber, int pageSize, CancellationToken cancellationToken)
        { 
            if(string.IsNullOrWhiteSpace(query)) throw new ArgumentNullException(nameof(query));
            if (pageNumber == 0) throw new ArgumentException(nameof(pageNumber));
            if (pageSize == 0) throw new ArgumentException(nameof(pageSize));

            const int totalRecords = 0;
            var results = await _context
                .Albums
                .FromSqlRaw("EXECUTE FindAlbums {0},{1},{2},{3} OUTPUT",
                    query, pageNumber, pageSize, totalRecords)
                .ToListAsync()
                .ConfigureAwait(false);

            var response = new FindAlbumResponse(results);
            return response;
        }
    }
}
