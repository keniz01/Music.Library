using Microsoft.EntityFrameworkCore;

namespace Music.Library.Repositories
{
    public class MusicDataContext : DbContext
    {
        public MusicDataContext(DbContextOptions<MusicDataContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //TODO: Move to configuration file.
            modelBuilder.Entity<GetAlbumData>( p =>
            {
                p.Property(m => m.Duration).HasColumnName("AlbumDuration");
                p.Property(m => m.Title).HasColumnName("AlbumTitle");
                p.Property(m => m.ReleaseYear).HasColumnName("AlbumYear");
                p.Property(m => m.AlbumId);
                p.Property(m => m.ArtistId);
                p.Property(m => m.ArtistName);
                p.Property(m => m.Labels);
                p.Property(m => m.Genres);
                p.HasNoKey();
             });

            base.OnModelCreating(modelBuilder);
        }

        public DbSet<GetAlbumData> Albums { get; set; }
    }
}
