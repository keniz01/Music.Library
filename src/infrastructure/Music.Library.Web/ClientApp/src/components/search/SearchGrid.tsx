import React, {Component} from 'react';
import Album from './Types/Album';
import Pager from './Pager';

interface IProps {
    albums: Album[],
    searchCount: number,
    searchQuery: string,
    itemsPerPage: number,
    fetchItemsPerPageCount: any,
    fetchPageNumber: any,
    fetchSearchData: any
}

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

    table() {
        return (
            <React.StrictMode>
                <div>
                    Found {this.props.searchCount} {this.props.searchCount === 1 ? 'result' : 'results' } for "{this.props.searchQuery}""
                </div>
                <table id="albumTable" className='table table-striped' aria-labelledby="tabelLabel">
                    <thead>
                        {this.headers()}
                    </thead>
                    <tbody>
                        {this.rows()}
                    </tbody>
                </table>
            </React.StrictMode>
        )
    }    
    render() {
        return (           
            <div>
                { this.props.searchCount > 0 ? this.table() : null }
                <Pager 
                    fetchSearchData={this.fetchSearchData}
                    searchQuery={this.props.searchQuery}
                    itemsPerPage={this.props.itemsPerPage} 
                    totalItems={this.props.searchCount}
                    fetchPageNumber={this.fetchPageNumber} />
            </div>
        )
    }
}