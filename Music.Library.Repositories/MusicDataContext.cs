using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Music.Library.Repositories
{
    public class MusicDataContext : DbContext
    {
        public MusicDataContext(DbContextOptions<MusicDataContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new GetAlbumDataEntityTypeConfiguration());
            base.OnModelCreating(modelBuilder);
        }

        public DbSet<GetAlbumData> Albums { get; set; }
    }

    public class GetAlbumDataEntityTypeConfiguration : IEntityTypeConfiguration<GetAlbumData>
    {
        public void Configure(EntityTypeBuilder<GetAlbumData> builder)
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
