using System;

namespace App1.Models
{
    public class Item
    {
        public string Id { get; set; }
        public string Text { get; set; }
        public bool IsComplete { get; set; }
        public int TotalCompletions { get; set; } = 1;
        public int Completions { get; set; } = 0;
    }
}