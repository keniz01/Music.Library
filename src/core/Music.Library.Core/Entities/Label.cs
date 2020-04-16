namespace Music.Library.Core.Entities
{
    public class Label
    {
        public Label(int id, string name)
        {
            Id = id;
            Name = name;
        }

        public int Id { get; }
        public string Name { get; }
    }
}