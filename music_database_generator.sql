USE [master]
GO
CREATE database [MusicContent]
GO
USE [MusicContent]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 20/03/2020 21:36:18 ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_StringTokenizer]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[ufn_StringTokenizer] 
(
	@SearchPhrase NVARCHAR(250), 
	@Delimiter CHAR(1) = ','
)
RETURNS NVARCHAR(250)   
AS 
BEGIN 
    DECLARE @TokenCount INT = (SELECT COUNT(*) FROM STRING_SPLIT(@SearchPhrase, @Delimiter))
    DECLARE @Counter INT = 0
    DECLARE @Token NVARCHAR(250) = NULL
    DECLARE @Query NVARCHAR(250) = ''

    -- Loop through tokens
    WHILE (@Counter < @TokenCount)
    BEGIN
        -- Get token value
        SELECT @Token = [value]
        FROM STRING_SPLIT(@SearchPhrase, @Delimiter)
        ORDER BY [value] ASC
        OFFSET @Counter ROWS
        FETCH NEXT 1 ROWS ONLY

        IF(@Counter != @TokenCount -1)
        BEGIN            
            SET @Query = @Query + '"*' + @Token + '*" OR '  
        END
        ELSE
        BEGIN
            SET @Query = @Query + '"*' + @Token + '*"'
        END

        -- Increment counter
        SET @Counter = @Counter + 1
    END
    RETURN @Query
END
GO
/****** Object:  Table [dbo].[AlbumGenres]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlbumGenres](
	[AlbumId] [int] NOT NULL,
	[GenreId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AlbumId] ASC,
	[GenreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlbumLabels]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlbumLabels](
	[AlbumId] [int] NOT NULL,
	[LabelId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AlbumId] ASC,
	[LabelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlbumRecords]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlbumRecords](
	[AlbumId] [int] NOT NULL,
	[RecordId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AlbumId] ASC,
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Albums]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Albums](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[YearReleased] [int] NULL,
	[Duration] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArtistAlbums]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArtistAlbums](
	[ArtistId] [int] NOT NULL,
	[AlbumId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AlbumId] ASC,
	[ArtistId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Artists]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artists](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Website] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Labels]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Labels](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Website] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Records]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Records](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[YearReleased] [int] NULL,
	[Duration] [int] NULL,
	[Position] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[AlbumGenres] ([AlbumId], [GenreId]) VALUES (1, 1)
GO
INSERT [dbo].[AlbumGenres] ([AlbumId], [GenreId]) VALUES (1, 2)
GO
INSERT [dbo].[AlbumGenres] ([AlbumId], [GenreId]) VALUES (2, 1)
GO
INSERT [dbo].[AlbumGenres] ([AlbumId], [GenreId]) VALUES (2, 2)
GO
INSERT [dbo].[AlbumGenres] ([AlbumId], [GenreId]) VALUES (3, 1)
GO
INSERT [dbo].[AlbumGenres] ([AlbumId], [GenreId]) VALUES (3, 2)
GO
INSERT [dbo].[AlbumGenres] ([AlbumId], [GenreId]) VALUES (4, 2)
GO
INSERT [dbo].[AlbumGenres] ([AlbumId], [GenreId]) VALUES (5, 1)
GO
INSERT [dbo].[AlbumLabels] ([AlbumId], [LabelId]) VALUES (1, 1)
GO
INSERT [dbo].[AlbumLabels] ([AlbumId], [LabelId]) VALUES (2, 4)
GO
INSERT [dbo].[AlbumLabels] ([AlbumId], [LabelId]) VALUES (3, 1)
GO
INSERT [dbo].[AlbumLabels] ([AlbumId], [LabelId]) VALUES (3, 2)
GO
INSERT [dbo].[AlbumLabels] ([AlbumId], [LabelId]) VALUES (4, 5)
GO
INSERT [dbo].[AlbumLabels] ([AlbumId], [LabelId]) VALUES (5, 6)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 1)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 2)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 3)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 4)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 5)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 6)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 7)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 8)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 9)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 10)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 11)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 12)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 13)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (1, 14)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 15)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 16)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 17)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 18)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 19)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 20)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 21)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 22)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 23)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 24)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 25)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 26)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 27)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 28)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 29)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (2, 30)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 31)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 32)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 33)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 34)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 35)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 36)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 37)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 38)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 39)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 40)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 41)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 42)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 43)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 44)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 45)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 46)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 47)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 48)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 49)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 50)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 51)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 52)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 53)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 54)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (3, 55)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 56)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 57)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 58)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 59)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 60)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 61)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 62)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 63)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 64)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 65)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 66)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 67)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 68)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 69)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 70)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 71)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 72)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (4, 73)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 74)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 75)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 76)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 77)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 78)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 79)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 80)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 81)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 82)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 83)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 84)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 85)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 86)
GO
INSERT [dbo].[AlbumRecords] ([AlbumId], [RecordId]) VALUES (5, 87)
GO
SET IDENTITY_INSERT [dbo].[Albums] ON 
GO
INSERT [dbo].[Albums] ([Id], [Title], [YearReleased], [Duration]) VALUES (1, N'The Doctor', 1999, 2929)
GO
INSERT [dbo].[Albums] ([Id], [Title], [YearReleased], [Duration]) VALUES (2, N'Ruff ''N'' Tuff', 1999, 0)
GO
INSERT [dbo].[Albums] ([Id], [Title], [YearReleased], [Duration]) VALUES (3, N'Gangsta for Life: The Symphony of David Brooks', 2007, 3719)
GO
INSERT [dbo].[Albums] ([Id], [Title], [YearReleased], [Duration]) VALUES (4, N'Stony Hill', 2017, 0)
GO
INSERT [dbo].[Albums] ([Id], [Title], [YearReleased], [Duration]) VALUES (5, N'Let''s Get Physical', 2008, 2970)
GO
SET IDENTITY_INSERT [dbo].[Albums] OFF
GO
INSERT [dbo].[ArtistAlbums] ([ArtistId], [AlbumId]) VALUES (1, 1)
GO
INSERT [dbo].[ArtistAlbums] ([ArtistId], [AlbumId]) VALUES (1, 2)
GO
INSERT [dbo].[ArtistAlbums] ([ArtistId], [AlbumId]) VALUES (2, 3)
GO
INSERT [dbo].[ArtistAlbums] ([ArtistId], [AlbumId]) VALUES (3, 4)
GO
INSERT [dbo].[ArtistAlbums] ([ArtistId], [AlbumId]) VALUES (4, 5)
GO
SET IDENTITY_INSERT [dbo].[Artists] ON 
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (1, N'Beenie Man', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (2, N'Mavado', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (3, N'Stephen Marley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (4, N'Elephant Man', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (5, N'Akshan', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (6, N'Anthony B', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (7, N'Mad Cobra', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (8, N'Damian ''Jr.Gong'' Marley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (9, N'Major Myjah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (10, N'Angie Martinez', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (11, N'Little Kirk', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (12, N'Mr Vegas', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (13, N'Jon B', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (14, N'3Suns', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (15, N'15-16-17', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (16, N'A.R.P', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (17, N'Abijah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (18, N'Abja', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (19, N'Abyssinians', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (20, N'Action Fire', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (21, N'Admiral Bailey', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (22, N'Admiral T', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (23, N'Admiral Tibett', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (24, N'Afayah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (25, N'African Bush Doctor', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (26, N'Aidonia', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (27, N'Aisha', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (28, N'Al Campbell', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (29, N'Al G', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (30, N'Al Pancho', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (31, N'Alaine', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (32, N'Alborosie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (33, N'Alison Hinds', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (34, N'Alley Cat', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (35, N'Allison', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (36, N'Alozade', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (37, N'Alpha Blonde', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (38, N'Alpheus', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (39, N'Alpheus Taylor', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (40, N'Althea & Donna', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (41, N'Alton Ellis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (42, N'Ambelique', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (43, N'Ancient King', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (44, N'Andrews Bees', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (45, N'Andrew Ranking', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (46, N'Andy Armstrong', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (47, N'Annette Brissette', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (48, N'Anthony Cruz', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (49, N'Anthony John', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (50, N'Anthony Malvo', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (51, N'Anthony Que', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (52, N'Anthony Red Rose', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (53, N'Antonio', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (54, N'Apache Indian', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (55, N'Archie Wonder', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (56, N'Army', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (57, N'Ash-!', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (58, N'Ashanti Waugh', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (59, N'Assassin', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (60, N'Aswad', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (61, N'Atowa', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (62, N'Audrey Hall', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (63, N'Avaran', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (64, N'Baby Cham', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (65, N'Baby Wayne', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (66, N'Bamboo B', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (67, N'Bambu Station', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (68, N'Barbara Jones', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (69, N'Barrington Levy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (70, N'Barrington Spence', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (71, N'Barry Boom', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (72, N'Barry Biggs', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (73, N'Barry Brown', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (74, N'Bascom X', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (75, N'Batch', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (76, N'Beef', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (77, N'Benaiah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (78, N'Beniton The Menace', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (79, N'Benjai', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (80, N'Benjy Myaz', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (81, N'Beres Hammond', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (82, N'Bescente', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (83, N'Big Mountain', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (84, N'Big Red', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (85, N'Big Youth', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (86, N'Bigga Haitian', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (87, N'Biggaton', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (88, N'Bill Campbell', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (89, N'Bitty McLean', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (90, N'Black Culture', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (91, N'Black Slate', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (92, N'Black Panther', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (93, N'Black Uhuru', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (94, N'Blacka Shine', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (95, N'Blackie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (96, N'Blessed', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (97, N'Bling Dawg', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (98, N'Black Shanti', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (99, N'Shanti Ites', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (100, N'Aaron Silk', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (101, N'Bob Andy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (102, N'Bob Marley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (103, N'Boris Gardiner', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (104, N'Born Jamericans', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (105, N'Bounty Hunter', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (106, N'Bounty Killer', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (107, N'Brian Tony Gold', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (108, N'Brick & Lace', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (109, N'Buccaneer', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (110, N'Buffalo Bill', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (111, N'Buju Banton', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (112, N'Bunji Garlin', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (113, N'Bunny Wailer', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (114, N'Burning Spear', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (115, N'Burrow Banton', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (116, N'Bushman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (117, N'Busy Signal', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (118, N'Byron Lee & Dragonaires', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (119, N'Bramma', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (120, N'Bugle', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (121, N'Cali P', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (122, N'Calibre', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (123, N'Cancer Mike', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (124, N'Candice', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (125, N'Capital Letters', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (126, N'Capleton', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (127, N'Caporal', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (128, N'Captain Sindbad', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (129, N'Carl Henry', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (130, N'Carl Meeks', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (131, N'Carlene Davis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (132, N'Carlton & The Shoes', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (133, N'Carroll Thompson', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (134, N'Carlton Livingston', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (135, N'Causion', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (136, N'Cecile', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (137, N'Cedella Marley Booker', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (138, N'Chaka Demus', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (139, N'Chakula', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (140, N'Chandley Duffus', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (141, N'Charlie Chaplin', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (142, N'Josey Wales', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (143, N'Cherine Anderson', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (144, N'Chevelle Franklyn', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (145, N'Chezidek', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (146, N'Chico', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (147, N'Chrisinti', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (148, N'Chuck Fender', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (149, N'Chuck Turner', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (150, N'Chukki Starr', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (151, N'CJ Lewis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (152, N'Coalishun', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (153, N'Cocoa Tea', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (154, N'Colin B', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (155, N'Collie Buddz', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (156, N'Cornell Campbell', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (157, N'Courtney Melody', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (158, N'Craig Dennis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (159, N'Courtney John', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (160, N'Crazy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (161, N'Crazy Chris aka CC', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (162, N'Crissy D', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (163, N'Culture', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (164, N'Cutty Ranks', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (165, N'Cynthia Richards', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (166, N'Cynthia Schloss', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (167, N'D''Angel', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (168, N'Daddy Freddy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (169, N'Daddy Lizard', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (170, N'Daddy Screw', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (171, N'Damian Marley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (172, N'Danny English', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (173, N'Danny I', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (174, N'Danny Red', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (175, N'Darien Prophecy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (176, N'Dåville', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (177, N'Daweh Congo', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (178, N'Dawg E Slaughter', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (179, N'Dawn Penn', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (180, N'De Apostle', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (181, N'Deborah Glasgow', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (182, N'Della Grant', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (183, N'Delly Ranks', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (184, N'Delroy Wilson', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (185, N'DeMarco', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (186, N'Dennis Bovell', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (187, N'Dennis Brown', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (188, N'Denyse Plummer', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (189, N'Derrick Lara', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (190, N'Desmond Dekker', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (191, N'Destra Garcia', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (192, N'Determine', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (193, N'Deva Bratt', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (194, N'Deyansa', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (195, N'Dezarie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (196, N'Diana King', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (197, N'Dirtsman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (198, N'Divine Creation', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (199, N'DJ Rondon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (200, N'Don Campbell', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (201, N'Don Carlos', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (202, N'Don Evans', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (203, N'Don Ricardo', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (204, N'Don Sharicon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (205, N'Don Yute', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (206, N'Dona V', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (207, N'Doniki', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (208, N'Donna Marie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (209, N'Donovan', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (210, N'Doreen Schaffer', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (211, N'Duane Stephenson', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (212, N'E.T. Webster', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (213, N'Echo Minott', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (214, N'Ed Robinson', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (215, N'Eddy Grant', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (216, N'Etana', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (217, N'Fantan Mojah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (218, N'Farenheit', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (219, N'Fiona', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (220, N'Firestorm', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (221, N'First Born', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (222, N'Fitta Warri', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (223, N'Flookie Don', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (224, N'Flourgon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (225, N'Foxy Brown', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (226, N'Fragga Ranks', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (227, N'Frankie Paul', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (228, N'Freddie McGregor', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (229, N'Frisco Kid', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (230, N'Future Troubles', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (231, N'Fyah Blaze', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (232, N'Revolution', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (233, N'Fucha Kid', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (234, N'G-Loc', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (235, N'G-Maffiah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (236, N'Gabby', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (237, N'Garnett Silk', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (238, N'Gaylads', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (239, N'General Degree', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (240, N'Gneral Levy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (241, N'Gneral T.K.', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (242, N'General Tree', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (243, N'Gentleman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (244, N'George Nooks', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (245, N'Ghost', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (246, N'Ginger Williams', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (247, N'Ginjah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (248, N'Gladiator', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (249, N'Glen Washington', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (250, N'Goofy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (251, N'Gregory Isaacs', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (252, N'Gregory Peck', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (253, N'Gyptian', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (254, N'H2O Phlo', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (255, N'Half Pint', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (256, N'Harry Toddler', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (257, N'Hawkeye', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (258, N'Heptons', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (259, N'High Intensity', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (260, N'Home T', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (261, N'HonoRebel', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (262, N'Horace Andy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (263, N'Hortense Ellis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (264, N'HR', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (265, N'Hugh Mundell', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (266, N'I Kong', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (267, N'I Mara', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (268, N'I Three', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (269, N'I Wayne', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (270, N'I-Octane', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (271, N'I-Roy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (272, N'Iba', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (273, N'Ijahman Levi', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (274, N'Ika Black', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (275, N'Ikahba', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (276, N'IKHO', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (277, N'Ini Kamoze', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (278, N'Inner Circle', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (279, N'Innocent Kru', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (280, N'Interns', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (281, N'Investigator', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (282, N'Iqulah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (283, N'Isaac Blackman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (284, N'Israel Vibration', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (285, N'Itals', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (286, N'Ivy Queen', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (287, N'Iwer George', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (288, N'Ifa', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (289, N'J-Satus', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (290, N'Jack Radics', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (291, N'Jacob Miller', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (292, N'Jagwa', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (293, N'Jah Beng', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (294, N'Jah Cure', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (295, N'Jah Mason', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (296, N'Jah Meek', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (297, N'Jah Myrakle', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (298, N'Jah Sun', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (299, N'Jah Warrior', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (300, N'Jahlicious', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (301, N'Jahmali', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (302, N'Jahman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (303, N'Jahmel', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (304, N'Jamelody', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (305, N'Janet Kay', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (306, N'Janet Lee Davis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (307, N'Javaughn', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (308, N'JC Lodge', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (309, N'JD Smoothie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (310, N'Jean McLean', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (311, N'Jennifer Lara', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (312, N'Jigsy King', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (313, N'Jimmy Cliff', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (314, N'Jimmy London', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (315, N'Jimmy Riley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (316, N'John Holt', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (317, N'John King', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (318, N'John McLean', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (319, N'John McLeon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (320, N'Dego Ranks', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (321, N'Johnny Clarke', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (322, N'Johnny Nash', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (323, N'Joseph Israel', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (324, N'Josie Mel', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (325, N'Jr. Demus', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (326, N'Jr. Dread', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (327, N'Judy Boucher', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (328, N'Judy Mowatt', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (329, N'Julian Marley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (330, N'Junior Byles', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (331, N'Junior Cat', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (332, N'Junior Dan', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (333, N'Junior Delgado', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (334, N'Junior Demus', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (335, N'Junior English', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (336, N'Junior Kelly', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (337, N'Junior Lion', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (338, N'Junior P', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (339, N'Junior Reid', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (340, N'Junior Tucker', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (341, N'Jah Hem', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (342, N'Jah Knight & Straight Up Sound', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (343, N'Kayla Bliss', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (344, N'Kevin Lyttle', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (345, N'Kofi', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (346, N'Kardinal Offishall', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (347, N'Kashief Lindo', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (348, N'KC Jockey', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (349, N'Ken Boothe', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (350, N'Khani Jones', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (351, N'Khari Kill', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (352, N'Kimberly', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (353, N'King David', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (354, N'King Jammy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (355, N'King Kong', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (356, N'Kingstones Ladies', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (357, N'Kiprich', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (358, N'Kirk Davies', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (359, N'KMC', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (360, N'Kris Kelli', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (361, N'Krosfyah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (362, N'Kula Ganja', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (363, N'Kulcha Don', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (364, N'Ky-Mani Marley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (365, N'L.O.C.', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (366, N'L.U.S.T', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (367, N'Lacksley Castel', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (368, N'Lady Ann', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (369, N'Lady G', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (370, N'Lady Passion', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (371, N'Lady Saw', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (372, N'Lady Shabba', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (373, N'Larry Marshall', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (374, N'Leftside & Esco', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (375, N'Lexxus', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (376, N'Lil Rick', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (377, N'Lil Vicious', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (378, N'Lion', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (379, N'Little John', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (380, N'Little Lenny', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (381, N'Lloyd Brown', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (382, N'LMJ', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (383, N'LMS', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (384, N'Lord Kossity', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (385, N'Lorna Asher', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (386, N'Louie Culture', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (387, N'Louise Mark', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (388, N'Love Joys', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (389, N'Lt. Stitchie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (390, N'Luciano', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (391, N'Lucky Dube', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (392, N'Luddy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (393, N'Lukie D', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (394, N'Lutan Fyah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (395, N'Lynx', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (396, N'Lyrical Benjie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (397, N'Lyricson', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (398, N'Ziggi', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (399, N'Zap Power', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (400, N'Zareb', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (401, N'Zebra', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (402, N'Zema', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (403, N'Ziggi Marley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (404, N'The Melody Makers', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (405, N'Zumjay', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (406, N'Ziggy Ranking', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (407, N'Yahadanai', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (408, N'Yami Bolo', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (409, N'Yaniss Odua', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (410, N'Yankee B', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (411, N'Yogie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (412, N'Yvad', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (413, N'Yvonne Curtis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (414, N'X-Kaliba', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (415, N'Xtatik', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (416, N'Machel Montana', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (417, N'Wailing Souls', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (418, N'Ward 21', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (419, N'Warrior King', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (420, N'Wayne Wonder', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (421, N'Wayne McArthur', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (422, N'Wayne Marshall', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (423, N'Wayne Smith', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (424, N'Wayne Wade', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (425, N'WCK', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (426, N'Webber Sisters', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (427, N'White Mice', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (428, N'Willie Williams', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (429, N'Winsome', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (430, N'Winston Curtis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (431, N'Winston Francis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (432, N'Winston Groovy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (433, N'Winstone Hussey', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (434, N'Winston Jarrett', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (435, N'Worl-A-Girl', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (436, N'Wycleaf Jean', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (437, N'Winston Reedy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (438, N'Viceroys', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (439, N'Vivian Jones', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (440, N'Voicemail', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (441, N'Volcano', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (442, N'Vybz Kartel', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (443, N'U-Roy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (444, N'UB40', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (445, N'Umojah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (446, N'Undivided Roots', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (447, N'Tanya Mulling', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (448, N'Teflon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (449, N'T.O.K', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (450, N'Taffari', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (451, N'Tallpree', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (452, N'Tami Chynn', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (453, N'Tamlins', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (454, N'Tanto Metro', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (455, N'Devonte', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (456, N'Tanya Stephens', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (457, N'Tarrus Riley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (458, N'Tenor Saw', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (459, N'Terror Fabulous', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (460, N'Terry Linen', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (461, N'The Bug', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (462, N'The Jamaicans', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (463, N'The Long Ranger', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (464, N'The Paragons', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (465, N'Third World', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (466, N'Three In One', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (467, N'Thriller Jenna', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (468, N'Thriller U', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (469, N'Tiger', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (470, N'Tinga Stewart', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (471, N'Tippie Irie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (472, N'Tito Simon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (473, N'Tolga', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (474, N'Toni Anderson', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (475, N'Tony & Brian Gold', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (476, N'Tony Benjamin', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (477, N'Tony Culture', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (478, N'Toni Curtis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (479, N'Tony Rebel', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (480, N'Tony Tuff', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (481, N'Toots', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (482, N'Top Cat', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (483, N'Touch', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (484, N'Toyan', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (485, N'Treagah Man', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (486, N'Trevor B', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (487, N'Trevor Hartley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (488, N'Trevor Sparks', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (489, N'TT Ross', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (490, N'Tuff Lion', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (491, N'Turbulence', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (492, N'Tyrone Taylor', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (493, N'QQ', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (494, N'Qsan Dia', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (495, N'Queen Ifrika', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (496, N'Queen Omega', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (497, N'Pam Hall', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (498, N'Panhead', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (499, N'Papa Dee', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (500, N'Papa Levi', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (501, N'Papa San', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (502, N'Pat Kelley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (503, N'Patch', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (504, N'Petra', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (505, N'Paulette Tajah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (506, N'Perfect', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (507, N'Peter Hunningale', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (508, N'Peter Metro', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (509, N'Peter Spence', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (510, N'Phillip Leo', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (511, N'Phyllis Dillon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (512, N'Pilot', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (513, N'Pliers', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (514, N'Powerman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (515, N'Pressure', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (516, N'Prezident Brown', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (517, N'Prince Buster', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (518, N'Prince Malachi', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (519, N'Prince Pankhi', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (520, N'Prince Sharifa', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (521, N'Promoe', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (522, N'Omar Silk', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (523, N'Omeil', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (524, N'One Love', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (525, N'Onila Bostic', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (526, N'Owen Gray', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (527, N'Nadine Sunderland', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (528, N'Nagota', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (529, N'Najah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (530, N'Nardo Ranks', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (531, N'Nasio', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (532, N'Natty King', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (533, N'Natural Black', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (534, N'Natural Way', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (535, N'Nazareness', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (536, N'Nemo', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (537, N'Nicky B', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (538, N'Ninja Cutty', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (539, N'Ninjaman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (540, N'Nisha K', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (541, N'Nitty Gritty', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (542, N'Nitty Kutchie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (543, N'Niyorah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (544, N'Nolan Irie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (545, N'Norris Man', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (546, N'Nu Vybes', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (547, N'Nemesis', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (548, N'M.I.A', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (549, N'Macka Diamond', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (550, N'Mad Lion', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (551, N'Edly Shines', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (552, N'Mada Nile', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (553, N'Madd Anju', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (554, N'Major Shackie', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (555, N'Malika Madremana', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (556, N'Marcia Griffiths', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (557, N'Marie Pierre', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (558, N'Mark Wonder', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (559, N'Marlon Asha', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (560, N'Massiah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (561, N'Masta Chang', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (562, N'Matisyahu', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (563, N'Matumbi', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (564, N'Max Romeo', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (565, N'Maxi Priest', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (566, N'Maximus Dan', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (567, N'Maytones', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (568, N'Mega Banton', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (569, N'Merciless', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (570, N'Merlyn Webber', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (571, N'Messenjah Selah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (572, N'Michael Gordon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (573, N'Michael Ross', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (574, N'Michelle Gordon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (575, N'Midnite', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (576, N'Mighty Diamond', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (577, N'Mikey D', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (578, N'Mikey General', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (579, N'Mikey Spice', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (580, N'Millie Small', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (581, N'Million Styles', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (582, N'Milton Henry', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (583, N'Misty In Roots', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (584, N'Molly Rose', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (585, N'Monster Shack Crew', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (586, N'Morgan Herritage', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (587, N'Mr Easy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (588, N'Mr Flash Gordon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (589, N'Mr G', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (590, N'Mr Peppa', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (591, N'Mr Slaughter', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (592, N'Ms Thing', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (593, N'Mr Triniti', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (594, N'Munga', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (595, N'Musical Youth', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (596, N'Mykal Somer', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (597, N'Mystic Man', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (598, N'Mystical Vibe', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (599, N'Mr Irieman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (600, N'RDX', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (601, N'Rebel Muffin', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (602, N'Revalation', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (603, N'Ragga P', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (604, N'Ranking Ann', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (605, N'Rnaking Joe', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (606, N'Ras Attitude', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (607, N'Ras Charmer', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (608, N'Ras Flabba', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (609, N'Ras Ghandi', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (610, N'Ras McBean', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (611, N'Ras Michael', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (612, N'The Sons Of Negus', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (613, N'Ras Michael Junior', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (614, N'Ras Myrhdak', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (615, N'Ras Shiloh', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (616, N'Rasitas', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (617, N'Rasta Pacey', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (618, N'Rayvon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (619, N'Red Dragon', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (620, N'Red Fox', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (621, N'Red Rat', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (622, N'Reggie Stepper', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (623, N'Richie Spice', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (624, N'Rhythm & Sound', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (625, N'Richie Stephens', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (626, N'Rik Rok', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (627, N'Ringo', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (628, N'Rising Sun', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (629, N'Rita Marley', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (630, N'Robert Ffrench', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (631, N'Robert Lee', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (632, N'Rod Taylor', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (633, N'Roger Robin', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (634, N'Rootsman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (635, N'Roy Richards', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (636, N'Ruddy Thomas', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (637, N'Rudy Mills', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (638, N'Rupee', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (639, N'Serani', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (640, N'Sizzla', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (641, N'Spragga Benz', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (642, N'Sabbattical Ahdah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (643, N'Sadiki', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (644, N'Sample King', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (645, N'Sanchez', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (646, N'Sandeeno', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (647, N'Sandra Cross', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (648, N'Sandra Reid', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (649, N'Sasha', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (650, N'Savana', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (651, N'Scare Dem Crew', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (652, N'Scotty', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (653, N'Screwdriver', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (654, N'Scrunter', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (655, N'Sean Kingstone', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (656, N'Sean Paul', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (657, N'Seeed', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (658, N'Selvie Wonder', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (659, N'Seventeen Plus', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (660, N'Shabba Ranks', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (661, N'Shadow', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (662, N'Shaggy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (663, N'Shalom', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (664, N'Shelly G', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (665, N'Shelly Thunder', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (666, N'Shepard', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (667, N'Sherwin Gardner', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (668, N'Shifta', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (669, N'Shinehead', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (670, N'Shockng Murray', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (671, N'Shurwayne Winchester', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (672, N'Silvercat', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (673, N'Simpleton', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (674, N'Singing Melody', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (675, N'Singing Sweet', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (676, N'Sista Gracy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (677, N'Sista Rebekah', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (678, N'Sistah Joyce', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (679, N'Sister Audrey', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (680, N'Sister Carol', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (681, N'Sister Nancy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (682, N'Sister Rasheda', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (683, N'Skillman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (684, N'Snow', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (685, N'Soldiers Of Jah Army', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (686, N'Sonya Spence', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (687, N'Sophia George', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (688, N'Spanner Banner', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (689, N'Sparrow', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (690, N'Spectacular', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (691, N'Spice', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (692, N'Pinchers', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (693, N'Toi', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (694, N'Star Lion Family', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (695, N'Steele', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (696, N'Steve Santana', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (697, N'Stone J', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (698, N'Suga Moss', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (699, N'Suga Roy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (700, N'Conrad Crystal', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (701, N'Sugar Black', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (702, N'Sugar Daddy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (703, N'Sugar Minott', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (704, N'Super C', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (705, N'Super Cat', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (706, N'Super P', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (707, N'Susan Cadogan', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (708, N'Sylvia Tella', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (709, N'Krayzie Bone', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (710, N'Paul Wall', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (711, N'Roache', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (712, N'Twist Young Blood', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (713, N'Benjamin', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (714, N'Einstein', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (715, N'X-Files', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (716, N'Chino', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (717, N'Keishera', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (718, N'Nazareken', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (719, N'Jodie Resther', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (720, N'Daddy Mory', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (721, N'The Maytals', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (722, N'Postman', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (723, N'Gailann', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (724, N'Scarface', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (725, N'Godfathers Asylum', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (726, N'Juicy', NULL)
GO
INSERT [dbo].[Artists] ([Id], [Name], [Website]) VALUES (727, N'Bertie Don', NULL)
GO
SET IDENTITY_INSERT [dbo].[Artists] OFF
GO
SET IDENTITY_INSERT [dbo].[Genres] ON 
GO
INSERT [dbo].[Genres] ([Id], [Name]) VALUES (1, N'Dancehall')
GO
INSERT [dbo].[Genres] ([Id], [Name]) VALUES (3, N'Lover''s Rock')
GO
INSERT [dbo].[Genres] ([Id], [Name]) VALUES (2, N'Reggae')
GO
SET IDENTITY_INSERT [dbo].[Genres] OFF
GO
SET IDENTITY_INSERT [dbo].[Labels] ON 
GO
INSERT [dbo].[Labels] ([Id], [Name], [Website]) VALUES (1, N'VP Records', NULL)
GO
INSERT [dbo].[Labels] ([Id], [Name], [Website]) VALUES (2, N'Assylum Records', NULL)
GO
INSERT [dbo].[Labels] ([Id], [Name], [Website]) VALUES (3, N'Greensleeves Records', NULL)
GO
INSERT [dbo].[Labels] ([Id], [Name], [Website]) VALUES (4, N'Fuel 2000 Records', NULL)
GO
INSERT [dbo].[Labels] ([Id], [Name], [Website]) VALUES (5, N'Island Records', NULL)
GO
INSERT [dbo].[Labels] ([Id], [Name], [Website]) VALUES (6, N'Bad Boy Records', NULL)
GO
SET IDENTITY_INSERT [dbo].[Labels] OFF
GO
SET IDENTITY_INSERT [dbo].[Records] ON 
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (1, N'Gospel Time', 1999, 225, 1)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (2, N'Let Him Go', 1999, 207, 2)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (3, N'The Doctor', 1999, 224, 3)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (4, N'Better Learn', 1999, 208, 4)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (5, N'Pride & Joy', 1999, 226, 5)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (6, N'Bad Man Nuh Flee', 1999, 195, 6)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (7, N'Bookshelf', 1999, 190, 7)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (8, N'One More Time', 1999, 226, 8)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (9, N'World Gone Mad', 1999, 192, 9)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (10, N'Kingston Hot', 1999, 177, 10)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (11, N'Tell Me (Re-mix)', 1999, 209, 11)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (12, N'Battery Dolly', 1999, 214, 12)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (13, N'Some Gal', 1999, 180, 13)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (14, N'Protect Me', 1999, 226, 14)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (15, N'Matie', 1999, 229, 1)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (16, N'Black Liberty', 1999, 215, 2)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (17, N'Gi Man Bun', 1999, 228, 3)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (18, N'Mouth Murderer', 1999, 220, 4)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (19, N'Good Times', 1999, 250, 5)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (20, N'Rough & Tough', 1999, 227, 6)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (21, N'Young Man Got The John', 1999, 231, 7)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (22, N'Push Up Your Hands', 1999, 214, 8)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (23, N'Three Against War', 1999, 247, 9)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (24, N'Bicycle Man', 1999, 210, 10)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (25, N'Mankind', 1999, 223, 11)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (26, N'Miss Brown & Pretty', 1999, 213, 12)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (27, N'Promises', 1999, 207, 13)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (28, N'Miss Angela', 1999, 253, 14)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (29, N'She''s Running from Her Life', 1999, 216, 15)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (30, N'Do the Butterfly', 1999, 201, 16)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (31, N'Parental Advisory', 2007, 18, 1)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (32, N'Angriest Introduction', 2007, 42, 2)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (33, N'Real McKoy (feat. Busy Signal)', 2007, 211, 3)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (34, N'Weh Dem A Do', 2007, 166, 4)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (35, N'A Father''s Prayer', 2007, 86, 5)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (36, N'They Fear Me', 2007, 265, 6)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (37, N'Definition Of A Gangsta', 2007, 34, 7)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (38, N'Dreaming', 2007, 202, 8)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (39, N'Don''t Cry', 2007, 142, 9)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (40, N'Cassava Piece Radio', 2007, 120, 10)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (41, N'Dying (feat. Serani)', 2007, 209, 11)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (42, N'David''s Interlude', 2007, 39, 12)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (43, N'Top Shotta Nah Miss', 2007, 178, 13)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (44, N'Joe D. Ratt', 2007, 39, 14)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (45, N'Last Night', 2007, 164, 15)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (46, N'A Snitch''s Eulogy', 2007, 82, 16)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (47, N'Amazing Grace', 2007, 203, 17)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (48, N'Touch Di Road', 2007, 192, 18)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (49, N'Me & My Dogs', 2007, 237, 19)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (50, N'APB', 2007, 10, 20)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (51, N'Gully Side', 2007, 172, 21)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (52, N'Squeeze Breats', 2007, 174, 22)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (53, N'Heart Beat (feat. Alaine)', 2007, 254, 23)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (54, N'Sadness', 2007, 255, 24)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (55, N'Born & Raised', 2007, 211, 25)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (56, N'Intro', 2017, 0, 1)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (57, N'Here We Go', 2017, 0, 2)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (58, N'Nail Pon Cross', 2017, 0, 3)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (59, N'R.O.A.R.', 2017, 0, 4)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (60, N'Medication', 2017, 0, 5)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (61, N'Time Travel', 2017, 0, 6)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (62, N'Living It Up', 2017, 0, 7)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (63, N'Looks Are Deceiving', 2017, 0, 8)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (64, N'The Struggle Discontinues', 2017, 0, 9)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (65, N'Autumn Leaves', 2017, 0, 10)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (66, N'Everybody Wants To Be Somebody', 2017, 0, 11)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (67, N'Upholstery', 2017, 0, 12)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (68, N'Grown & Sexy', 2017, 0, 13)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (69, N'Perfect Picture', 2017, 0, 14)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (70, N'So A Child May Follow', 2017, 0, 15)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (71, N'Slave Mill', 2017, 0, 16)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (72, N'Caution', 2017, 0, 17)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (73, N'Speak Life', 2017, 0, 18)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (74, N'Drop Dead', 2008, 184, 1)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (75, N'Dem Nah Ready', 2008, 221, 2)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (76, N'Feel The Steam (feat. Chris Brown)', 2008, 221, 3)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (77, N'Throw Your Hands Up (feat. Rihanna)', 2008, 203, 4)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (78, N'Five-O (feat. Wyclef Jean & P.Diddy)', 2008, 279, 5)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (79, N'Jump (feat. Swizz Beats)', 2008, 187, 6)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (80, N'Back That Thing On Me (Shake That) [feat. Mario Winans]', 2008, 192, 7)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (81, N'Our World (feat. Demarco)', 2008, 153, 8)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (82, N'The Way We Roll (Remix) [feat. Busta Rhymes & Shaggy]', 2008, 251, 9)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (83, N'Sweep The Floor', 2008, 199, 10)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (84, N'Body Talk (feat. Kat Deluna & Jha Jha)', 2008, 244, 11)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (85, N'Who Wanna', 2008, 186, 12)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (86, N'Five-O (Remix) [feat. Wyclef, Swizz Beats, Assassin, Yung Joc & P.Diddy]', 2008, 245, 13)
GO
INSERT [dbo].[Records] ([Id], [Title], [YearReleased], [Duration], [Position]) VALUES (87, N'Gully Crepa (Hidden Track)', 2008, 205, 14)
GO
SET IDENTITY_INSERT [dbo].[Records] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Artists__737584F62C0E1588]    Script Date: 20/03/2020 21:36:20 ******/
ALTER TABLE [dbo].[Artists] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Genres__737584F6F6DDB03B]    Script Date: 20/03/2020 21:36:20 ******/
ALTER TABLE [dbo].[Genres] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Labels__737584F6E4EBC64A]    Script Date: 20/03/2020 21:36:20 ******/
ALTER TABLE [dbo].[Labels] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Albums] ADD  DEFAULT ((0)) FOR [YearReleased]
GO
ALTER TABLE [dbo].[Albums] ADD  DEFAULT ((0)) FOR [Duration]
GO
ALTER TABLE [dbo].[Records] ADD  DEFAULT ((0)) FOR [YearReleased]
GO
ALTER TABLE [dbo].[Records] ADD  DEFAULT ((0)) FOR [Duration]
GO
ALTER TABLE [dbo].[Records] ADD  DEFAULT ((0)) FOR [Position]
GO
ALTER TABLE [dbo].[AlbumGenres]  WITH CHECK ADD FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Albums] ([Id])
GO
ALTER TABLE [dbo].[AlbumGenres]  WITH CHECK ADD FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
GO
ALTER TABLE [dbo].[AlbumLabels]  WITH CHECK ADD FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Albums] ([Id])
GO
ALTER TABLE [dbo].[AlbumLabels]  WITH CHECK ADD FOREIGN KEY([LabelId])
REFERENCES [dbo].[Labels] ([Id])
GO
ALTER TABLE [dbo].[AlbumRecords]  WITH CHECK ADD FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Albums] ([Id])
GO
ALTER TABLE [dbo].[AlbumRecords]  WITH CHECK ADD FOREIGN KEY([RecordId])
REFERENCES [dbo].[Records] ([Id])
GO
ALTER TABLE [dbo].[ArtistAlbums]  WITH CHECK ADD FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Albums] ([Id])
GO
ALTER TABLE [dbo].[ArtistAlbums]  WITH CHECK ADD FOREIGN KEY([ArtistId])
REFERENCES [dbo].[Artists] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[FindAlbums]    Script Date: 20/03/2020 21:36:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[FindAlbums]
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
		,Labels NVARCHAR(250)  
		,Genres NVARCHAR(250)  
	)

	INSERT INTO @TempSearchResults
	SELECT
		DISTINCT
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
		,Labels  
		,Genres  
	FROM @TempSearchResults
	ORDER BY AlbumId ASC
    OFFSET @PageSize * (@PageNo - 1) ROWS
    FETCH NEXT @PageSize ROWS ONLY 
END
GO
/****** Object:  StoredProcedure [dbo].[FindAlbumsWithRecords]    Script Date: 20/03/2020 21:36:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[FindAlbumsWithRecords]
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
