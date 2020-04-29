/****** Object:  Table [dbo].[Records]    Script Date: 20/03/2020 21:36:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='Records' AND XTYPE='U')
BEGIN
	CREATE TABLE [dbo].[Records](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[Title] [nvarchar](250) NOT NULL,
		[YearReleased] [int] NULL DEFAULT 0,
		[Duration] [int] NULL DEFAULT 0,
		[Position] [int] NULL DEFAULT 0,
	PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
END
GO