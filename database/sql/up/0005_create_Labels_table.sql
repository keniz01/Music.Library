/****** Object:  Table [dbo].[Labels]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='Labels' AND XTYPE='U')
BEGIN
	CREATE TABLE [dbo].[Labels](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[Name] [nvarchar](250) UNIQUE NOT NULL,
		[Website] [nvarchar](250) NULL,
	PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
END
GO