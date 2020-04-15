using Music.Library.Core.Common.Extensions;
using System.Collections.Generic;

namespace Music.Library.Core.Entities
{
    public sealed class Record
    {
        private Record(int? artistId, string artistName, int? albumId,
            int? duration, string title, int? releaseYear, string labels, string genres)
        {
            ArtistId = artistId;
            ArtistName = artistName;
            AlbumId = albumId;
            Duration = duration.Format();
            Title = title;
            ReleaseYear = releaseYear;
            Labels = labels.ToListOfLabels();
            Genres = genres.ToListOfGenres();
        }

        public int? ArtistId { get; }

        public string ArtistName { get; }

        public int? AlbumId { get; }

        public string Duration { get; }

        public string Title { get; }

        public int? ReleaseYear { get; }

        public List<Label> Labels { get; }

        public List<Genre> Genres { get; }

        public class Builder
        {
            private int? _artistId;
            private string _artistName;
            private int? _albumId;
            private int? _duration;
            private string _title;
            private int? _releaseYear;
            private string _labels;
            private string _genres;

            public Builder SetArtistId(int? artistId)
            {
                _artistId = artistId;
                return this;
            }

            public Builder SetDuration(int? duration)
            {
                _duration = duration;
                return this;
            }

            public Builder SetAlbumId(int? albumId)
            {
                _albumId = albumId;
                return this;
            }

            public Builder SetArtistName(string artistName)
            {
                _artistName = artistName;
                return this;
            }

            public Builder SetLabels(string labels)
            {
                _labels = labels;
                return this;
            }

            public Builder SetGenres(string genres)
            {
                _genres = genres;
                return this;
            }

            public Builder SetReleaseYear(int? releaseYear)
            {
                _releaseYear = releaseYear;
                return this;
            }

            public Builder SetTitle(string title)
            {
                _title = title;
                return this;
            }

            public Record Build() =>
                new Record(_artistId, _artistName,
                    _albumId, _duration, _title, _releaseYear, _labels, _genres);
        }
    }
}