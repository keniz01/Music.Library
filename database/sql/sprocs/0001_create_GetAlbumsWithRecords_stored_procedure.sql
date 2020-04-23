/****** Object:  StoredProcedure [dbo].[FindAlbumsWithRecords]    Script Date: 20/03/2020 21:36:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetAlbumsWithRecords]
(
	@SearchPhrase NVARCHAR(250),
	@PageNo INT = 1,
	@PageSize INT = 100,
	@TotalRecords INT = 0 OUTPUT
)
AS
BEGIN
	DECLARE @TempSearchResults TABLE
	(
		ArtistId INT DEFAULT 0
		,ArtistName NVARCHAR(250)
		,AlbumId INT DEFAULT 0
		,AlbumDuration INT DEFAULT 0
		,AlbumTitle NVARCHAR(250)
		,AlbumYear INT DEFAULT 0
		,RecordId INT DEFAULT 0
		,RecordTitle NVARCHAR(250)  
		,RecordDuration INT DEFAULT 0
		,RecordPosition INT DEFAULT 0
		,RecordYear INT DEFAULT 0
		,Labels NVARCHAR(250)  
		,Genres NVARCHAR(250)  
	)

	INSERT INTO @TempSearchResults
	SELECT
		Artist.Id ArtistId, 
		Artist.[Name] ArtistName, 
		Album.Id AlbumId, 
		Album.Duration AlbumDuration, 
		Album.Title AlbumTitle, 
		Album.YearReleased AlbumYear, 
		Record.Id RecordId, 
		Record.Title RecordTitle, 
		Record.Duration RecordDuration, 
		Record.Position, 
		Record.YearReleased RecordYear,
		STUFF(( SELECT ';' + CAST([Label].Id AS VARCHAR(1000)) + ',' + [Label].[Name] AS [text()]
					FROM Labels [Label]
					INNER JOIN AlbumLabels AL ON AL.LabelId = [Label].Id
					WHERE AL.AlbumId = Album.Id
					FOR XML PATH('')
					), 1, 1, '' ) AS [Label],
		STUFF(( SELECT ';' + CAST(Genre.Id AS VARCHAR(1000)) + ',' + Genre.[Name] AS [text()]
					FROM Genres Genre
					INNER JOIN AlbumGenres AG ON AG.GenreId = Genre.Id
					WHERE AG.AlbumId = Album.Id
					FOR XML PATH('')
					), 1, 1, '' ) AS [Genre]
	FROM Artists Artist
	LEFT JOIN ArtistAlbums AA ON Artist.Id = AA.ArtistId
	LEFT JOIN Albums Album ON Album.Id = AA.AlbumId
	LEFT JOIN AlbumRecords AR ON AR.AlbumId = Album.Id
	LEFT JOIN Records Record ON Record.Id = AR.RecordId
	WHERE 1 = 1
	AND ((@SearchPhrase IS NULL OR Artist.[Name] LIKE '%' + @SearchPhrase +'%')
		OR (@SearchPhrase IS NULL OR Album.[Title] LIKE '%' + @SearchPhrase +'%')
		OR (@SearchPhrase IS NULL OR Record.[Title] LIKE '%' + @SearchPhrase +'%'))

	SET @TotalRecords = @@ROWCOUNT

	SELECT 
		ArtistId
		,ArtistName
		,AlbumId
		,AlbumDuration
		,AlbumTitle
		,AlbumYear
		,RecordId[MusicContent.old]
		,RecordTitle 
		,RecordDuration
		,RecordPosition
		,RecordYear
		,Labels  
		,Genres  
	FROM @TempSearchResults
	ORDER BY AlbumId, RecordPosition ASC
    OFFSET @PageSize * (@PageNo - 1) ROWS
    FETCH NEXT @PageSize ROWS ONLY 
END
GO