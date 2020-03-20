namespace Music.Library.Core.Models
{

    /// <summary>
    /// The search query results container.
    /// </summary>
    public class FindAlbumsData
    {
        /// <summary>
        /// The artist id.
        /// </summary>
        public int? ArtistId { get; set; }

        /// <summary>
        /// The artist name.
        /// </summary>
        public string ArtistName { get; set; }

        /// <summary>
        /// The album id.
        /// </summary>
        public int? AlbumId { get; set; }

        /// <summary>
        /// The album length.
        /// </summary>
        public int? Duration { get; set; }

        /// <summary>
        /// The album title.
        /// </summary>
        public string Title { get; set; }

        /// <summary>
        /// The album year.
        /// </summary>
        public int? ReleaseYear { get; set; }

        /// <summary>
        /// The album labels.
        /// </summary>
        public string Labels { get; set; }

        /// <summary>
        /// The album genres.
        /// </summary>
        public string Genres { get; set; }
    }
}