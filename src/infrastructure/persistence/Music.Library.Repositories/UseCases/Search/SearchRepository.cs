using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Music.Library.Core.Entities;
using Music.Library.Core.Services.Repositories;
using Music.Library.Repositories.Common.Extensions;
using System.Collections.Generic;
using System.Data;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Repositories
{
    public class SearchRepository : ISearchRepository
    {
        private readonly MusicDataContext _context;
        public SearchRepository(MusicDataContext context) => _context = context;

        public async Task<SearchPackage> GetSearchResponseAsync(string query, int pageNumber, int pageSize, CancellationToken cancellationToken)
        {
            DataExtensions.Guard(new List<object> { query, pageNumber, pageSize });

            var totalRecords = new SqlParameter("@TotalRecords", DbType.Int32) { Direction = ParameterDirection.Output };
            var results = await _context
                .Catalogue
                .FromSqlRaw("EXEC GetAlbums {0},{1},{2},{3} OUTPUT",
                    query, pageNumber, pageSize, totalRecords)
                .ToListAsync(cancellationToken)
                .ConfigureAwait(false);

            return new SearchPackage { Response = results.ToModel(), ResponseCount = (int)totalRecords.Value };
        }
    }
}
