/****** Object:  Table [dbo].[AlbumLabels]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='AlbumLabels' AND XTYPE='U')
BEGIN
	CREATE TABLE [dbo].[AlbumLabels](
		[AlbumId] [int] NOT NULL,
		[LabelId] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[AlbumId] ASC,
		[LabelId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
END
GO