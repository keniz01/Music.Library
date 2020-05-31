import Album from '../Shared/IAlbum';

export default interface IState {
    data: {
        response: Album[],
        responseCount: number
    },
    query: string,
    searching: boolean,
    itemsPerPage: number,
    pageNumber: number
}