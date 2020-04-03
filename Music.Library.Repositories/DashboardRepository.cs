using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Music.Library.Core.Features.Home;
using Music.Library.Core.Models;
using Music.Library.Core.Repositories;
using Music.Library.Repositories.Helpers.Extensions;
using System.Linq;
using System.Collections.Generic;
using System.Data;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Repositories
{
    public class DashboardRepository : IDashboardRepository
    {
        private readonly MusicDataContext _context;
        public DashboardRepository(MusicDataContext context) => _context = context;

        public async Task<GetDashboardResponse> GetDashboardAsync(CancellationToken cancellationToken)
        {
            var parameters = new Dictionary<string, SqlParameter>
            {
                { "@TotalArtists", new SqlParameter("@TotalArtists", DbType.Int32) { Direction = ParameterDirection.Output } },
                { "@TotalAlbums", new SqlParameter("@TotalAlbums", DbType.Int32) { Direction = ParameterDirection.Output } },
                { "@TotalGenres", new SqlParameter("@TotalGenres", DbType.Int32) { Direction = ParameterDirection.Output } },
                { "@TotalLabels", new SqlParameter("@TotalLabels", DbType.Int32) { Direction = ParameterDirection.Output } },
                { "@TotalRecords", new SqlParameter("@TotalRecords", DbType.Int32) { Direction = ParameterDirection.Output } }
            };

            var sqlStatement = "EXEC [GetDashboardStatistics] " +
                "{0} OUTPUT,{1} OUTPUT,{2} OUTPUT,{3} OUTPUT,{4} OUTPUT";

            var results = await _context
                .Albums
                .FromSqlRaw(sqlStatement, parameters.Values.Cast<SqlParameter>().ToArray())
                .ToListAsync(cancellationToken)
                .ConfigureAwait(false);

            var albums = results.ToModel();
            var statistics = new GetStatisticsResult
            (
                (int)parameters["@TotalRecords"].Value,                
                (int)parameters["@TotalAlbums"].Value,
                (int)parameters["@TotalGenres"].Value,
                (int)parameters["@TotalLabels"].Value,
                (int)parameters["@TotalArtists"].Value
            );
            return new GetDashboardResponse(statistics, albums);
        }
    }
}
