﻿using Music.Library.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Music.Library.Repositories.Helpers.Extensions
{
    public static class DataModelExtensions
    {
        public static List<GetAlbumResult> ToModel(this List<GetAlbumData> data) =>
            data.Select(album => new GetAlbumResult(album.ArtistId, album.ArtistName,
                album.AlbumId, album.Duration, album.Title, album.ReleaseYear, album.Labels, album.Genres))
            .ToList();

        public static void Guard(this List<object> parameters) => parameters.ForEach(parameter => {
            switch(parameter)
            {
                case int intParameter:
                    if (intParameter == 0) throw new ArgumentOutOfRangeException(nameof(parameter));
                    break;
                case string stringParameter:
                    if (string.IsNullOrWhiteSpace(stringParameter)) throw new ArgumentNullException(nameof(parameter));
                    break;
            }
        });
    }
}
