import React, {Component} from 'react';
import IProps from './IProps';
import Pager from './Pager';


export default class SearchGrid extends Component<IProps> {
    static displayName = SearchGrid.name;

    constructor(props: any) {
        super(props);

        this.fetchPageNumber = this.fetchPageNumber.bind(this);
        this.fetchSearchData = this.fetchSearchData.bind(this);
    }

    fetchPageNumber(pageNumber: number) {
        this.props.fetchPageNumber(pageNumber);       
    }

    fetchSearchData(data: any) {
        this.props.fetchSearchData(data); 
    }

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

    pager() {
        return (
            <Pager 
                fetchSearchData={this.fetchSearchData}
                searchQuery={this.props.searchQuery}
                itemsPerPage={this.props.itemsPerPage} 
                totalItems={this.props.searchCount}
                fetchPageNumber={this.fetchPageNumber} />              
        )
    }

    table() {
        return (
            <React.StrictMode>
                <table aria-labelledby="tabelLabel">
                    <caption>
                        Found {this.props.searchCount} {this.props.searchCount === 1 ? 'result' : 'results' } for "{this.props.searchQuery}""
                    </caption>
                    <thead>
                        {this.headers()}
                    </thead>
                    <tbody>
                        {this.rows()}
                    </tbody>
                </table>   
                { this.pager() }           
            </React.StrictMode>
        )
    }    
    render() {
        return (           
            <div className="paged-data">
                { this.props.searchCount > 0 ? this.table() : null }
            </div>
        )
    }
}