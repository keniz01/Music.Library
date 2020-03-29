import React from 'react';
import './App.css';

export default class App extends React.Component {
  constructor(props){
    super(props)

    this.state = {
      albums: []
    };

    this.handleKeyPress = this.handleKeyPress.bind(this);
  }

  getData(query){
    fetch(`http://localhost:5001/api/search/${query}/1/100`)
    .then(res => res.json())
    .then(
      (result) => {
        this.setState({
          albums: result.albums
        });

        console.log(result.albums);
      },
      (error) => {
        console.log(error);
      }
    )
  }

  handleKeyPress(event) {
    if(event.which === 13 && event.target.value.length) {
      this.getData(event.target.value);
    }
  }

  renderTableHeaders() {
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

  renderTableData() {
    return (
        this.state.albums.map((album, index) => {
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

  renderTable() {
    return (
      <div>
      <table id="albumTable">
        <thead>
          {this.renderTableHeaders()}
        </thead>
        <tbody>
          {this.renderTableData()}
        </tbody>
      </table>
    </div>
    )
  }

  render() {
    return (
      <div className="App">
        <div className="app-header">
          <a href="/">
            <div>Music Library</div>
          </a>
        </div> 
        <div className="search-input-area">
            <input type="text" id="searchTextInput" onKeyPress={this.handleKeyPress} />
        </div>
        { this.state.albums.length ? this.renderTable() : null }
        <div className="footer">
          Copyright @ Music Library.
        </div>
      </div>
    );
    }
}
