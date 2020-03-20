using Microsoft.EntityFrameworkCore;
using Music.Library.Core.Models;

namespace Music.Library.Repositories
{
    public class MusicDataContext : DbContext
    {
        public MusicDataContext(DbContextOptions<MusicDataContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<FindAlbumsData>().Property(p => p.Duration).HasColumnName("AlbumDuration");
            modelBuilder.Entity<FindAlbumsData>().Property(p => p.Title).HasColumnName("AlbumTitle");
            modelBuilder.Entity<FindAlbumsData>().Property(p => p.ReleaseYear).HasColumnName("AlbumYear");
            modelBuilder.Entity<FindAlbumsData>().HasNoKey();
            base.OnModelCreating(modelBuilder);
        }

        public DbSet<FindAlbumsData> Albums { get; set; }
    }
}
