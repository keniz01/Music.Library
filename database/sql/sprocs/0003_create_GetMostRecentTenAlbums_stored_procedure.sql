/****** Object:  StoredProcedure [dbo].[GetAlbums]    Script Date: 20/03/2020 21:36:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].GetLatestTenAlbums AS
BEGIN
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
	FROM Artists Artist
	JOIN ArtistAlbums ON Artist.Id = ArtistAlbums.ArtistId
	JOIN Albums Album ON Album.Id = ArtistAlbums.AlbumId
END
GO