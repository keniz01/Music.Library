import React from 'react';
import Helpers from './Helpers';
import SearchResultsGrid  from './SearchResultsGrid';
import Pager from './Pager';
import DashBoardMetricsGrid from '../Dashboard/DashBoardMetricsGrid';

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

    this.handleKeyEnterPress = this.handleKeyEnterPress.bind(this);
    this.handlePageChange = this.handlePageChange.bind(this);
  }

  fetchData = async (searchQuery, selectedPageNumber) => {
    const itemsPerPage = 10;
    const data = await Helpers.fetchSearchData(searchQuery, selectedPageNumber, itemsPerPage);
    this.setState({ 
      albums: data.response,
      totalItems: data.responseCount,
      title: `Found ${data.responseCount} results for "${searchQuery}"`,
      isSearch: true,
      itemsPerPage: itemsPerPage,
      searchQuery: searchQuery
     });  
    };

  handlePageChange(selectedPageNumber){
    this.fetchData(this.state.searchQuery, selectedPageNumber);
  }

  handleKeyEnterPress(event){
      const searchQuery = event.target.value;
      if(event.which === 13 && searchQuery.length) {
        this.fetchData(searchQuery, 1);  
      }      
  }

  componentDidMount() {
    (async () => {
      const data = await Helpers.fetchInitialLoadData();
      this.setState({ 
        albums: data.latestAlbums,
        title: `The most recent ${data.latestAlbums.length} albums`,
        statistics: data.metrics,
        isSearch: false
      }); 
    })();
  }

  render() {
    return (
      <div>
        <DashBoardMetricsGrid statistics={this.state.statistics} />
        <div className="search-input-area">
            <input type="text" id="searchTextInput" onKeyPress={this.handleKeyEnterPress} />
        </div>
        <div>         
          <SearchResultsGrid albums={this.state.albums } title={this.state.title} />
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
