import React from 'react';
import Helpers from './Helpers';
import AlbumsTable  from './AlbumsTable';
import Pager from './Pager';
import Dashboard from '../Dashboard/Dashboard';

export default class App extends React.Component {
  constructor(){
    super();

    this.state = {
      albums: [],
      title: '',
      statistics: {},
      isSearch: false,
      totalItems: 0,
      itemsPerPage: 0,
      searchQuery: ''
    };

    this.handleKeyPress = this.handleKeyPress.bind(this);
    this.handlePageChange = this.handlePageChange.bind(this);
  }

  fetchData = async (searchQuery, selectedPageNumber) => {
    const itemsPerPage = 10;
    const data = await Helpers.fetchSearchData(searchQuery, selectedPageNumber, itemsPerPage);
    this.setState({ 
      albums: data.albums,
      totalItems: data.totalItemCount,
      title: `Found ${data.totalItemCount} results for "${searchQuery}"`,
      isSearch: true,
      itemsPerPage: itemsPerPage,
      searchQuery: searchQuery
     });  
    };

  handlePageChange(selectedPageNumber){
    //Fix for now
    this.fetchData(this.state.searchQuery, selectedPageNumber);
  }

  handleKeyPress(event){
      const searchQuery = event.target.value;
      if(event.which === 13 && searchQuery.length) {
        this.fetchData(searchQuery, 1);  
      }      
  }

  componentDidMount() {
    (async () => {
      const data = await Helpers.fetchInitialLoadData();
      this.setState({ 
        albums: data.albums,
        title: `The most recent ${data.albums.length} albums`,
        statistics: data.statistics,
        isSearch: false
      }); 
    })();
  }

  render() {
    return (
      <div>
        <Dashboard statistics={this.state.statistics} />
        <div className="search-input-area">
            <input type="text" id="searchTextInput" onKeyPress={this.handleKeyPress} />
        </div>
        <div>         
          <AlbumsTable albums={this.state.albums } title={this.state.title} />
          <Pager 
            itemsPerPage={this.state.itemsPerPage} 
            isSearch={this.state.isSearch}
            totalItems={this.state.totalItems}
            handlePageChange={this.handlePageChange}/>
        </div>
      </div>
    );
  }
}
