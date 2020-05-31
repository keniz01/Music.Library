import Album from '../Shared/IAlbum';

export default interface StateProps {
    albums: Album[],
    title: string,
    loading: boolean
    statistics: any
}