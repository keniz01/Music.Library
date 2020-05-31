import React, { Component } from 'react';
import StateProps from './IProps';
import DashBoard from './DashBoard';
import Albums from './Albums';

export default class Home extends Component<{}, StateProps> {
    static displayName = Home.name;

    constructor(props: any) {
      super(props);
      this.state = {
        albums: [],
        title: '',
        statistics: {},
        loading: true
      };
    }

    async fetchData() {
        const data = await fetch(`http://localhost:5000/api/dashboard/`)
            .then(response => response.json());  
        
        this.setState({ 
            albums: data.latestAlbums,
            title: `The most recent ${data.latestAlbums.length} albums`,
            statistics: data.metrics,
            loading: false
        });
    }

    componentDidMount() {
        this.fetchData();
    }

    render() {

        return (
            <div id="albums-table-container">
                <Albums { ...this.state } />
                <DashBoard { ...this.state } />
            </div>
        )
    }
}
