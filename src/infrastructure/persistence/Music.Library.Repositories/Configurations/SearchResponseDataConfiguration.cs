﻿using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Music.Library.Repositories.Models;

namespace Music.Library.Repositories
{
    public class SearchResponseDataConfiguration : IEntityTypeConfiguration<SearchData>
    {
        public void Configure(EntityTypeBuilder<SearchData> builder)
        {
            builder.Property(m => m.Duration).HasColumnName("AlbumDuration");
            builder.Property(m => m.Title).HasColumnName("AlbumTitle");
            builder.Property(m => m.ReleaseYear).HasColumnName("AlbumYear");
            builder.Property(m => m.AlbumId);
            builder.Property(m => m.ArtistId);
            builder.Property(m => m.ArtistName);
            builder.Property(m => m.Labels);
            builder.Property(m => m.Genres);
            builder.HasNoKey();
        }
    }
}
