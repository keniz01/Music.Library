using Music.Library.Core.Common.Extensions;
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
            data.Select(album => new Record
            {
                ArtistId = album.ArtistId,
                ArtistName = album.ArtistName,
                AlbumId = album.AlbumId,
                Duration = album.Duration.Format(),
                Title = album.Title,
                ReleaseYear = album.ReleaseYear,
                Labels = album.Labels.ToListOfLabels(),
                Genres = album.Genres.ToListOfGenres()
            }).ToList();

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
