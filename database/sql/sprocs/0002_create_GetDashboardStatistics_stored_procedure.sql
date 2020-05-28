/****** Object:  StoredProcedure [dbo].[GetDashboardStatistics]    Script Date: 01/04/2020 18:01:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetDashboardStatistics]
(
	@TotalArtists INT OUTPUT,
	@TotalAlbums INT OUTPUT,
	@TotalGenres INT OUTPUT,
	@TotalLabels INT OUTPUT,
	@TotalRecords INT OUTPUT
)
AS
BEGIN
	SELECT @TotalArtists = COUNT(1) FROM Artists
	SELECT @TotalAlbums = COUNT(1) FROM Albums
	SELECT @TotalGenres = COUNT(1) FROM Genres
	SELECT @TotalRecords = COUNT(1) FROM Records
	SELECT @TotalLabels = COUNT(1) FROM Labels

	SELECT TOP 10
		Artist.Id ArtistId, 
		Artist.[Name] ArtistName, 
		Album.Id AlbumId, 
		Album.Duration AlbumDuration, 
		Album.Title AlbumTitle, 
		Album.YearReleased AlbumYear, 
		STUFF(( SELECT ';' + CAST([Label].Id AS VARCHAR(1000)) + ',' + [Label].[Name] AS [text()]
					FROM Labels [Label]
					INNER JOIN AlbumLabels AL ON AL.LabelId = [Label].Id
					WHERE AL.AlbumId = Album.Id
					FOR XML PATH('')
					), 1, 1, '' ) AS [Labels],
		STUFF(( SELECT ';' + CAST(Genre.Id AS VARCHAR(1000)) + ',' + Genre.[Name] AS [text()]
					FROM Genres Genre
					INNER JOIN AlbumGenres AG ON AG.GenreId = Genre.Id
					WHERE AG.AlbumId = Album.Id
					FOR XML PATH('')
					), 1, 1, '' ) AS [Genres]
	FROM Albums Album
	LEFT JOIN ArtistAlbums ON Album.Id = ArtistAlbums.AlbumId
	LEFT JOIN Artists Artist ON Artist.Id = ArtistAlbums.ArtistId
END
GO