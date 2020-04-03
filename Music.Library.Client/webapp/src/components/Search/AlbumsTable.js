import React from 'react';

export default class AlbumsTable extends React.Component {

    constructTableHeaders() {
        return (
          <tr>
            <th>Artist</th>
            <th>Album</th>
            <th>Duration</th>
            <th>Year</th>
            <th>Labels</th>
            <th>Genres</th>
        </tr>
        )
    }

    /**
     * Construct table rows.
     */
    constructTableRows() {
        return (
            this.props.albums.map((album, index) => {
              const {artistName, title, duration, releaseYear, labels, genres} = album;
              return (
                <tr key={index}>
                  <td>{artistName}</td>
                  <td>{title}</td>
                  <td>{duration}</td>
                  <td>{releaseYear}</td>
                  <td>{labels.map(label => label.name).join(', ')}</td>
                  <td>{genres.map(genre => genre.name).join(', ')}</td>
                </tr>
              )
            })
        )
    }

    /**
     * Construct data table.
     */
    constructTable() {
        return (
            <div>
                <table id="albumTable">
                <caption>{this.props.title}</caption>
                <thead>
                    {this.constructTableHeaders()}
                </thead>
                <tbody>
                    {this.constructTableRows()}
                </tbody>
                </table>
            </div>
        )
    }

    render() {
        return (
            <div>
                { this.props.albums.length ? this.constructTable() : null }
            </div>
        )
    }
}