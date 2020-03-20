using MediatR;
using System.Collections.Generic;

namespace Music.Library.Core.Features.FindAlbums
{
    public class FindAlbumRequest : IRequest<FindAlbumResponse>
    {
        public FindAlbumRequest(string query, int pageNumber, int pageSize)
        {
            Query = query;
            PageSize = pageSize;
            PageNumber = pageNumber;
        }

        public string Query { get; }
        public int PageSize { get; }
        public int PageNumber { get; }
    }
}
