namespace Albums.Model
{
    public class Album
    {
        public long Id { get; set; }
        public string? Title { get; set; }
        public string? Artist { get; set; }
        public string? Genre { get; set; }
        public string? YearOFRelease { get; set; }
        public string? RecordLabel { get; set; }
        public int Price { get; set; }
        public int NumberOfTracks { get; set; }
    }
}