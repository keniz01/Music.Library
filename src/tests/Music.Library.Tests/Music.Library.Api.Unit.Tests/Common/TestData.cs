using Music.Library.Core.Common.Extensions;
using Music.Library.Core.Entities;
using System;
using System.Collections.Generic;

namespace Music.Library.Api.Unit.Tests.Common
{
    public static class TestData
    {
        public static List<Record> CreateAlbums() => new List<Record>
            {
                new Record
                {
                    ArtistId = 1,
                    ArtistName = "Mad Cobra",
                    AlbumId = 1,
                    Duration = ((int?)2900).Format(),
                    Title = "Hard To Wet, Easy To Dry",
                    ReleaseYear = 1994,
                    Labels = "1,Columbia Records".ToListOfLabels(),
                    Genres = "1,Dancehall;2,Reggae Fusion".ToListOfGenres()
                },
                new Record
                {
                    ArtistId = 2,
                    ArtistName = "Mr Vegas",
                    AlbumId = 2,
                    Duration = ((int?)2900).Format(),
                    Title = "Heads High",
                    ReleaseYear = 1998,
                    Labels = "2,Greensleeves Records".ToListOfLabels(),
                    Genres = "1,Dancehall;3,Reggae;4,Soca".ToListOfGenres()
                },
                new Record
                {
                    ArtistId = 2,
                    ArtistName = "Mr. Vegas",
                    AlbumId = 3,
                    Duration = ((int?)2900).Format(),
                    Title = "Mr. Vegas",
                    ReleaseYear = 1999,
                    Labels = "3,VP Records".ToListOfLabels(),
                    Genres = "1,Dancehall;3,Reggae;4,Soca".ToListOfGenres()
                },
                new Record
                {
                    ArtistId = 3,
                    ArtistName = "Beenie Man",
                    AlbumId = 4,
                    Duration = ((int?)2900).Format(),
                    Title = "Defend It",
                    ReleaseYear = 1994,
                    Labels = "3,VP Records".ToListOfLabels(),
                    Genres = "1,Dancehall;3,Reggae;4,Soca".ToListOfGenres()
                },
                new Record
                {
                    ArtistId = 3,
                    ArtistName = "Beenie Man",
                    AlbumId = 5,
                    Duration = ((int?)2900).Format(),
                    Title = "Weh Dem A Go Do...Can't Stop Cocoa Tea ",
                    ReleaseYear = 1984,
                    Labels = "5,Volcano Records".ToListOfLabels(),
                    Genres = "1,Dancehall;3,Reggae;4,Soca".ToListOfGenres()
                }
            };

        public static DashBoardMetrics CreateMetrics() =>
            new DashBoardMetrics
            {
                TotalRecords = 1000,
                TotalAlbums = 150,
                TotalGenres = 10,
                TotalLabels = 8,
                TotalArtists = 90
            };
    }
}
