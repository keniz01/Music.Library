import React, { Component } from 'react';

export default class Header extends Component {
    static displayName = Header.name;
    render() {
        return (
            <div>            
                <a href="/">
                    <div>Music Library</div>
                </a>
          </div>
        )
    }
}
