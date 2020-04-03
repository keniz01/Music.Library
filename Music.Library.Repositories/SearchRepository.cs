using Microsoft.EntityFrameworkCore;
using Music.Library.Core.Features.Search;
using Music.Library.Core.Repositories;
using Music.Library.Repositories.Helpers.Extensions;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Repositories
{
    public class SearchRepository : ISearchRepository
    {
        private readonly MusicDataContext _context;
        public SearchRepository(MusicDataContext context) => _context = context;

        public async Task<GetAlbumsResponse> GetAlbumsAsync(string query, int pageNumber, int pageSize, CancellationToken cancellationToken)
        {
            DataModelExtensions.Guard(new List<object> { query, pageNumber, pageSize });

            const int totalRecords = 0;
            var results = await _context
                .Albums
                .FromSqlRaw("EXECUTE GetAlbums {0},{1},{2},{3} OUTPUT",
                    query, pageNumber, pageSize, totalRecords)
                .ToListAsync(cancellationToken)
                .ConfigureAwait(false);

            return new GetAlbumsResponse(results.ToModel());
        }
    }
}
