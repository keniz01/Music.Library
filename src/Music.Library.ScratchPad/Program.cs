using System;
using System.Collections.Generic;
using System.Linq;

namespace Music.Library.ScratchPad
{
    static class Program
    {
        static void Main(string[] args)
        {
            args = new string[] { };
            string str = null; // "1,Dancehall;3,Lover's Rock;2,Reggae;5,Ragga;3,Dancehall;4,Reggae;3,Dancehall";
            
            List<Genre> items = str
                .Split(new[] { ";" }, StringSplitOptions.RemoveEmptyEntries)
                .Select(i => i.Split(new[] { "," }, StringSplitOptions.RemoveEmptyEntries))
                .Select(x => new Genre(Convert.ToInt32(x[0]), x[1]))
            .ToList();

            items.ForEach(item => Console.WriteLine(item.Id + ", " + item.Name));
        }
    }

    public class Genre
    {
        public Genre(int id, string name)
        {
            Id = id;
            Name = name;
        }

        public int Id { get; }
        public string Name { get; }
    }
}
