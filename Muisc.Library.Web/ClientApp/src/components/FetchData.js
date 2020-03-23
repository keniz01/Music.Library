import React, { Component } from 'react';

export class FetchData extends Component {
    static displayName = FetchData.name;

    constructor(props) {
        super(props);
        this.state = { albums: [], loading: true };
    }

    componentDidMount() {
        this.populateAlbumData();
    }

    static renderAlbumsTable(albums) {
        return (
            <table className='table table-striped' aria-labelledby="tableLabel">
                <thead>
                    <tr>
                        <th>ArtistId</th>
                        <th>ArtistName</th>
                        <th>AlbumId</th>
                        <th>Duration</th>
                        <th>Title</th>
                        <th>ReleaseYear</th>
                        <th>Labels</th>
                        <th>Genres</th>
                    </tr>
                </thead>
                <tbody>
                    {albums.map((album, index) =>
                        <tr key={index}>
                            <td>{album.ArtistId}</td>
                            <td>{album.ArtistName}</td>
                            <td>{album.AlbumId}</td>
                            <td>{album.Duration}</td>
                            <td>{album.Title}</td>
                            <td>{album.ReleaseYear}</td>
                            <td>{album.Labels}</td>
                            <td>{album.Genres}</td>
                        </tr>
                    )}
                </tbody>
            </table>
        );
    }

    render() {
        let contents = this.state.loading
            ? <p><em>Loading...</em></p>
            : FetchData.renderAlbumsTable(this.state.forecasts);

        return (
            <div>
                <h1 id="tabelLabel" >Weather forecast</h1>
                <p>This component demonstrates fetching data from the server.</p>
                {contents}
            </div>
        );
    }

    async populateAlbumData() {
        const query = 'man';
        const response = await fetch('http://localhost/api/search/' + query + '/' + 1 + '/' + 100);
        const data = await response.json();
        this.setState({ albums: data, loading: false });
    }
}
