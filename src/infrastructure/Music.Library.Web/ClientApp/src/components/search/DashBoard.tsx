import React, { Component } from 'react';
import StateProps from './Types/StateProps';

export default class DashBoard extends Component<StateProps> {

    headers() {
        return (
          <tr>
            <th>Artists</th>
            <th>Albums</th>
            <th>Records</th>
            <th>Labels</th>
            <th>Genres</th>
        </tr>
        )
    }

    rows() {
        const { totalArtists, totalAlbums, totalRecords, totalLabels, totalGenres } = this.props.statistics;
        return (
            <tr key={Math.random()}>
                <td>{totalArtists}</td>
                <td>{totalAlbums}</td>
                <td>{totalRecords}</td>
                <td>{totalLabels}</td>
                <td>{totalGenres}</td>
            </tr>
        )
    }

    table() {
        return (
            <table id="albumTable" className='table table-striped' aria-labelledby="tabelLabel">
                <caption>Music Library statistics</caption>
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
          <React.StrictMode>
              { this.table() }
          </React.StrictMode>
        )
    }
}