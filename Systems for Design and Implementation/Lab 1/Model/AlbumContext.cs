using Microsoft.EntityFrameworkCore;

namespace Albums.Model;

    public class AlbumContext : DbContext
    {
        public AlbumContext(DbContextOptions<AlbumContext> options)
            : base(options)
    {
    }
    public DbSet<Album> Albums {get; set; } = null!;

}