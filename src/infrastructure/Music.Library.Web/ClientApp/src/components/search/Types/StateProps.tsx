import Album from './Album';

export default interface StateProps {
    albums: Album[],
    title: string,
    loading: boolean
    statistics: any
}