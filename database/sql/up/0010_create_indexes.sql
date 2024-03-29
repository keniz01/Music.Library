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
--GO
--ALTER TABLE [dbo].[Albums] ADD  DEFAULT ((0)) FOR [YearReleased]
--GO
--ALTER TABLE [dbo].[Albums] ADD  DEFAULT ((0)) FOR [Duration]
--GO
---ALTER TABLE [dbo].[Records] ADD  DEFAULT ((0)) FOR [YearReleased]
--GO
--ALTER TABLE [dbo].[Records] ADD  DEFAULT ((0)) FOR [Duration]
--GO
--ALTER TABLE [dbo].[Records] ADD  DEFAULT ((0)) FOR [Position]
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