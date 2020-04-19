using System.Collections.Generic;

namespace Music.Library.Core.Entities
{
    public class Record
    {
        public int? ArtistId { get; set; }

        public string ArtistName { get; set; }

        public int? AlbumId { get; set; }

        public string Duration { get; set; }

        public string Title { get; set; }

        public int? ReleaseYear { get; set; }

        public List<Label> Labels { get; set; }

        public List<Genre> Genres { get; set; }
    }
}