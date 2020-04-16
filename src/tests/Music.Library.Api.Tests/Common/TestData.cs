using Music.Library.Core.Entities;
using System.Collections.Generic;

namespace Music.Library.Api.Tests.Common
{
    public static class TestData
    {
        public static List<Record> CreateAlbums() => new List<Record>
            {
                new Record.Builder()
                    .SetArtistId(1)
                    .SetArtistName("Mad Cobra")
                    .SetAlbumId(1)
                    .SetDuration(2900)
                    .SetTitle("Hard To Wet, Easy To Dry")
                    .SetArtistId(1994)
                    .SetLabels("1,Columbia Records")
                    .SetGenres("1,Dancehall;2,Reggae Fusion")
                .Build(),
                new Record.Builder()
                    .SetArtistId(2)
                    .SetArtistName("Mr Vegas")
                    .SetAlbumId(2)
                    .SetDuration(2900)
                    .SetTitle("Heads High")
                    .SetArtistId(1998)
                    .SetLabels("2,Greensleeves Records")
                    .SetGenres("1,Dancehall;3,Reggae;4,Soca")
                .Build(),
                new Record.Builder()
                    .SetArtistId(2)
                    .SetArtistName("Mr. Vegas")
                    .SetAlbumId(3)
                    .SetDuration(2900)
                    .SetTitle("Mr. Vegas")
                    .SetArtistId(1999)
                    .SetLabels("3,VP Records")
                    .SetGenres("1,Dancehall;3,Reggae;4,Soca")
                .Build(),
                new Record.Builder()
                    .SetArtistId(3)
                    .SetArtistName("Beenie Man")
                    .SetAlbumId(4)
                    .SetDuration(2900)
                    .SetTitle("Defend It")
                    .SetArtistId(1994)
                    .SetLabels("3,VP Records")
                    .SetGenres("1,Dancehall;3,Reggae;4,Soca")
                .Build(),
                new Record.Builder()
                    .SetArtistId(3)
                    .SetArtistName("Beenie Man")
                    .SetAlbumId(5)
                    .SetDuration(2900)
                    .SetTitle("Weh Dem A Go Do...Can't Stop Cocoa Tea ")
                    .SetArtistId(1984)
                    .SetLabels("5,Volcano Records")
                    .SetGenres("1,Dancehall;3,Reggae;4,Soca")
                .Build()
            };

        public static DashBoardMetrics CreateMetrics() => new DashBoardMetrics(1000, 150, 10, 8, 90);
    }
}
