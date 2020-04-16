using Music.Library.Core.Entities;
using Music.Library.Repositories.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Music.Library.Repositories.Common.Extensions
{
    public static class DataExtensions
    {
        public static List<Record> ToModel(this List<SearchData> data) =>
            data.Select(album => new Record.Builder()
                .SetArtistId(album.ArtistId)
                .SetArtistName(album.ArtistName)
                .SetAlbumId(album.AlbumId)
                .SetDuration(album.Duration)
                .SetTitle(album.Title)
                .SetArtistId(album.ReleaseYear)
                .SetLabels(album.Labels)
                .SetGenres(album.Genres)
            .Build()).ToList();

        public static void Guard(this List<object> parameters) => parameters.ForEach(parameter =>
        {
            switch(parameter)
            {
                case int intParameter:
                    if(intParameter == 0)
                        throw new ArgumentOutOfRangeException(nameof(parameter));
                    break;
                case string stringParameter:
                    if(string.IsNullOrWhiteSpace(stringParameter))
                        throw new ArgumentNullException(nameof(parameter));
                    break;
            }
        });
    }
}
