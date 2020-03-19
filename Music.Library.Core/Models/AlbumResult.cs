using System;
using System.Collections.Generic;

namespace Music.Library.Core.Models
{
    public class AlbumResult
    {
        public Artist Artist { get; set; }
        public Album Album { get; set; }
        public List<Label> Labels { get; set; } = new List<Label>();
        public List<Genre> Genres { get; set; } = new List<Genre>();
    }
}
