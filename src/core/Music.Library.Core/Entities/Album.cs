namespace Music.Library.Core.Entities
{
    public class Album : RecordBase
    {
        public Album(int? artistId, string artistName, int? albumId,
            int? duration, string title, int? releaseYear, string labels, string genres)
            : base(artistId, artistName, albumId, duration, title, releaseYear, labels, genres)
        {

        }
    }
}