import React, { Component } from 'react';

export default class Header extends Component {
    static displayName = Header.name;
    render() {
        return (
            <div className='d-flex w-50 flex-grow'>            
                <a href="/">
                    <div>Music Library</div>
                </a>
          </div>
        )
    }
}
