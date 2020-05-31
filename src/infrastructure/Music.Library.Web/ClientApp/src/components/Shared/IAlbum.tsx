import Label from './ILabel';
import Genre from './IGenre';

export default interface IAlbum {
    artistName: string, 
    title: string, 
    duration: string, 
    releaseYear: number, 
    labels: Label[], 
    genres: Genre[]
}