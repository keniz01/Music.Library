import React from 'react';

export default class StatisticsTable extends React.Component {

    TableHeaders() {
        return (
          <tr>
            <th>Total Artists</th>
            <th>Total Albums</th>
            <th>Total Tracks</th>
            <th>Total Labels</th>
            <th>Total Genres</th>
          </tr>
        )
    }

    /**
     * Construct table rows.
     */
    TableRows() {
        const {totalArtists, totalAlbums, totalRecords, totalLabels, totalGenres } = this.props.statistics;
        return (
            <tr>
                <td>{totalArtists}</td>
                <td>{totalAlbums}</td>
                <td>{totalRecords}</td>
                <td>{totalLabels}</td>
                <td>{totalGenres}</td>
            </tr>
        )
    }

    /**
     * Construct data table.
     */
    DataTable() {
        return (
            <div>
                <table id="statsTable">
                <caption>The latest Music Library statistics.</caption>
                <thead>
                    {this.TableHeaders()}
                </thead>
                <tbody>
                    {this.TableRows()}
                </tbody>
                </table>
            </div>
        )
    }

    render() {
        return (
            <div className={ this.props.isVisible ? "show" : "hide" }>
                { this.DataTable() }
            </div>
        )
    }
}