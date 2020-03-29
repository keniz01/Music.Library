namespace Music.Library.Repositories
{
    public class GetAlbumData
    {
        public GetAlbumData(int? artistId, string artistName, int? albumId,
            int? duration, string title, int? releaseYear, string labels, string genres)
        {
            ArtistId = artistId;
            ArtistName = artistName;
            AlbumId = albumId;
            Duration = duration;
            Title = title;
            ReleaseYear = releaseYear;
            Labels = labels;
            Genres = genres;
        }

        public int? ArtistId { get; private set; }

        public string ArtistName { get; }

        public int? AlbumId { get; }

        public int? Duration { get; }

        public string Title { get; }

        public int? ReleaseYear { get; }

        public string Labels { get; }

        public string Genres { get; }
    }
}
