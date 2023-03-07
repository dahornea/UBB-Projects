using System.ComponentModel.DataAnnotations.Schema;

namespace Model

{
    public class Album
    {
        public long AlbumId { get; set; }
        public string? Title { get; set; }
        public string? Genre { get; set; }
        public string? YearOFRelease { get; set; }
        public string? RecordLabel { get; set; }
        public int Price { get; set; }
        public int NumberOfTracks { get; set; }

        [ForeignKey("ArtistId")]
        public Artist? Artist { get; set; } // one artist to many albums
    }
}