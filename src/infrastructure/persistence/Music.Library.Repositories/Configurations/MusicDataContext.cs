using Microsoft.EntityFrameworkCore;
using Music.Library.Repositories.Models;

namespace Music.Library.Repositories
{
    public class MusicDataContext : DbContext
    {
        public MusicDataContext(DbContextOptions<MusicDataContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new SearchResponseDataConfiguration());
            base.OnModelCreating(modelBuilder);
        }

        public DbSet<SearchData> Catalogue { get; set; }
    }
}
