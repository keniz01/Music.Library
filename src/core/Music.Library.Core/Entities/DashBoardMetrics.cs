﻿namespace Music.Library.Core.Entities
{
    public class DashBoardMetrics
    {
        public DashBoardMetrics(int totalRecords,
            int totalAlbums, int totalGenres, int totalLabels, int totalArtists)
        {
            TotalGenres = totalGenres;
            TotalLabels = totalLabels;
            TotalRecords = totalRecords;
            TotalArtists = totalArtists;
            TotalAlbums = totalAlbums;
        }

        public int TotalAlbums { get; }
        public int TotalArtists { get; }
        public int TotalLabels { get; }
        public int TotalGenres { get; }
        public int TotalRecords { get; }
    }
}