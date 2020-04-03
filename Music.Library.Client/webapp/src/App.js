import React from 'react';
import './App.css';
import SearchUI from './components/Search/SearchUI';

export default class App extends React.Component {

  render() {
    return (
      <div className="App">
        <div className="app-header">
          <a href="/">
            <div>Music Library</div>
          </a>
        </div> 
        <SearchUI />
        <div className="footer">
          Copyright @ Music Library.
        </div>
      </div>
    );
    }
}
