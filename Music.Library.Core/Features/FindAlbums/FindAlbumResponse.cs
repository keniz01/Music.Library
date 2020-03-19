using Music.Library.Core.Models;
using System.Collections.Generic;

namespace Music.Library.Core.Features.FindAlbums
{
    public class FindAlbumResponse
    {
        public FindAlbumResponse(Artist artist, Album album, List<Label> labels, List<Genre> genres)
        {
            Artist = artist; 
            Album = album; 
            Labels = labels;
            Genres = genres;
        }

        public Artist Artist { get; }
        public Album Album { get; set; }
        public List<Label> Labels { get; } = new List<Label>();
        public List<Genre> Genres { get; } = new List<Genre>();
    }
}
