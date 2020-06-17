import Album from '../Shared/IAlbum';

export default interface IProps {
    albums: Album[],
    searchCount: number,
    searchQuery: string,
    itemsPerPage: number,
    // fetchItemsPerPageCount: any,
    fetchPageNumber: any,
    fetchSearchData: any
}