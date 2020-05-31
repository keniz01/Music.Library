import React, { Component } from 'react';
import IProps from './IProps'

export default class Albums extends Component<IProps> {
    static displayName = Albums.name;
 
    headers() {
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

    rows() {
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

    table() {
        return (
            <table id="albumTable" className='table table-striped' aria-labelledby="tabelLabel">
                <caption>{this.props.title}</caption>
                <thead>
                    {this.headers()}
                </thead>
                <tbody>
                    {this.rows()}
                </tbody>
            </table>
        )
    }

    render() {
        
        return (
            <div id="albums-table-container">
                { this.props.albums.length 
                    ? this.props.loading
                        ? <p><em>Loading...</em></p>
                        : this.table() 
                    : null }
            </div>
        )
    }
}