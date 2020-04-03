import React from 'react';
import '../../App.css';
import Helpers from './Helpers';
import AlbumsTable  from './AlbumsTable';
import StatisticsTable  from './StatisticsTable';

export default class App extends React.Component {
  constructor(){
    super();

    this.state = {
      albums: [],
      title: '',
      statistics: {},
      isSearch: false
    };

    this.handleKeyPress = this.handleKeyPress.bind(this);
  }

  async handleKeyPress(event){
    const value = event.target.value;
    if(event.which === 13 && value.length) {
      const albums = await Helpers.fetchSearchData(value);
      this.setState({ 
        albums: albums,
        title: `Found ${albums.length} results for "${value}"`,
        isSearch: true
       });   
    }
  }

  async componentDidMount() {
    const data = await Helpers.fetchInitialLoadData();
    this.setState({ 
      albums: data.albums,
      title: `The most recent ${data.albums.length} albums`,
      statistics: data.statistics,
      isSearch: false
    }); 
  }

  render() {
    return (
      <div>
        <div className="search-input-area">
            <input type="text" id="searchTextInput" onKeyPress={this.handleKeyPress} />
        </div>
        <div className="dashboard-tables">
          <AlbumsTable albums={ this.state.albums } title={this.state.title} />
          <StatisticsTable statistics={ this.state.statistics } isSearch={ this.state.isSearch }/>
        </div>
      </div>
    );
  }
}
