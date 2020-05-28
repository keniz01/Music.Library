import Label from './Label';
import Genre from './Genre';

export default interface Album {
    artistName: string, 
    title: string, 
    duration: string, 
    releaseYear: number, 
    labels: Label[], 
    genres: Genre[]
}