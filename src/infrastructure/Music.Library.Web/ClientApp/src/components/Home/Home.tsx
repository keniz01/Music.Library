import React, { Component } from 'react';
import StateProps from './IProps';
import DashBoard from './DashBoard';
import Albums from './Albums';
import DashBoardServiceApi from '../Services/DashBoardServiceApi';

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

    componentDidMount() {
        DashBoardServiceApi.fetchData()
            .then(data =>     
                this.setState({ 
                    albums: data.latestAlbums,
                    title: `The most recent ${data.latestAlbums.length} albums`,
                    statistics: data.metrics,
                    loading: false
                }));
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
