using Music.Library.Core.Helpers.Extensions;
using System.Collections.Generic;

namespace Music.Library.Core.Models
{

    public class GetAlbumResult
    {
        public GetAlbumResult(int? artistId, string artistName, int? albumId,
            int? duration, string title, int? releaseYear, string labels, string genres)
        {
            ArtistId = artistId;
            ArtistName = artistName;
            AlbumId = albumId;
            Duration = duration.DurationFormat();
            Title = title;
            ReleaseYear = releaseYear;
            Labels = labels.ToListOfLabels();
            Genres = genres.ToListOfGenres();
        }

        public int? ArtistId { get; private set; }

        public string ArtistName { get; }

        public int? AlbumId { get; }

        public string Duration { get; }

        public string Title { get; }

        public int? ReleaseYear { get; }

        public List<Label> Labels { get; }

        public List<Genre> Genres { get; }
    }
}