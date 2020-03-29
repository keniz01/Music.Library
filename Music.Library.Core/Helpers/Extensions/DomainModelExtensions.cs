﻿using Music.Library.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Music.Library.Core.Helpers.Extensions
{
    public static class DomainModelExtensions
    {
        public static List<Genre> ToListOfGenres(this string genres) => (genres ?? string.Empty)
                .Split(new[] { ";" }, StringSplitOptions.RemoveEmptyEntries)
                .Select(item => item.Split(new[] { "," }, StringSplitOptions.RemoveEmptyEntries))
                .Select(item => new Genre(Convert.ToInt32(item[0]), item[1]))
            .ToList();

        public static string DurationFormat(this int? duration) => TimeSpan.FromSeconds(duration.GetValueOrDefault()).ToString();
        
        public static List<Label> ToListOfLabels(this string labels) => (labels ?? string.Empty)
                        .Split(new[] { ";" }, StringSplitOptions.RemoveEmptyEntries)
                        .Select(item => item.Split(new[] { "," }, StringSplitOptions.RemoveEmptyEntries))
                        .Select(item => new Label(Convert.ToInt32(item[0]), item[1]))
                    .ToList();
    }
}
