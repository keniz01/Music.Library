namespace Music.Library.Core.Entities
{
    public class Pagination
    {
        public Pagination(int pageNumber, int pageSize)
        {
            PageSize = pageSize;
            PageNumber = pageNumber;
        }

        public int PageNumber { get; }
        public int PageSize { get; }
    }
}
