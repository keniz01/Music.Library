import React from 'react';
import './App.scss';
import SearchUI from './components/Search/SearchUI';

export default class App extends React.Component {

  render() {
    return (
      <div className="App">
        {/* Header */}
        <div className="app-header">
          <a href="/">
            <div>Music Library</div>
          </a>
        </div> 
        {/* Content */}       
        <SearchUI />
        {/* Footer */}
        <div className="footer">
          Copyright @ Music Library.
        </div>
      </div>
    );
    }
}
