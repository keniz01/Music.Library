using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Music.Library.Core.Entities;
using Music.Library.Core.Services.Repositories;
using Music.Library.Repositories.Common.Extensions;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Music.Library.Repositories
{
    public class DashBoardRepository : IDashBoardRepository
    {
        private readonly MusicDataContext _context;
        public DashBoardRepository(MusicDataContext context) => _context = context;

        public async Task<DashBoardPackage> GetDashBoardAsync(CancellationToken cancellationToken)
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
                .Catalogue
                .FromSqlRaw(sqlStatement, parameters.Values.Cast<SqlParameter>().ToArray())
                .ToListAsync(cancellationToken)
                .ConfigureAwait(false);

            var albums = results.ToModel();
            var metrics = new DashBoardMetrics
            {
                TotalRecords = (int)parameters["@TotalRecords"].Value,
                TotalAlbums = (int)parameters["@TotalAlbums"].Value,
                TotalGenres = (int)parameters["@TotalGenres"].Value,
                TotalLabels = (int)parameters["@TotalLabels"].Value,
                TotalArtists = (int)parameters["@TotalArtists"].Value
            };
            return new DashBoardPackage { Metrics = metrics, LatestAlbums = albums };
        }
    }
}
