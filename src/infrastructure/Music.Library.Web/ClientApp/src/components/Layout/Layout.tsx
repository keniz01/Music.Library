﻿import React, { Component } from 'react';
import Home from '../Home/Home';
import Header from '../Shared/Header';
import SearchInput from '../SearchInput/SearchInput';
import Footer from '../Shared/Footer';
import SearchGrid from '../SearchGrid/SearchGrid';
import IState from './IState';

export default class Layout extends Component<{}, IState> {
    static displayName  = Layout.name

    constructor(props: any){
        super(props);

        this.state = {
            query: '',
            searching: false,
            data: {
                response: [],
                responseCount: 0
            },
            itemsPerPage: 10,
            pageNumber: 1
        };

        this.fetchSearchData = this.fetchSearchData.bind(this);
        this.fetchPageNumber = this.fetchPageNumber.bind(this);
        this.fetchSearchQuery = this.fetchSearchQuery.bind(this);
    }

    fetchPageNumber = (pageNumber: number) => {
        this.setState({ pageNumber: pageNumber });
    }

    fetchItemsPerPageCount = (itemsPerPage: number) => {
        this.setState({ itemsPerPage: itemsPerPage });
    }

    fetchSearchQuery = (searchQuery: string) => {
        this.setState({ query: searchQuery, searching: true })
    }

    fetchSearchData(data: any) {
        this.setState({ data: data});
    }

    render() {
       
        const searchGridProps = {
            albums: this.state.data.response,
            searchCount: this.state.data.responseCount,
            searchQuery: this.state.query,
            itemsPerPage: this.state.itemsPerPage,
            fetchPageNumber: this.fetchPageNumber,
            fetchSearchData: this.fetchSearchData
        }

        return (
            <div className='content'>
                <div className='header'>
                    <Header />
                    <SearchInput 
                        fetchSearchData={this.fetchSearchData}
                        fetchSearchQuery={this.fetchSearchQuery}
                        fetchItemsPerPageCount={this.fetchItemsPerPageCount} />
                </div>
                <div className="tabular-data">
                    { this.state.searching ? <SearchGrid { ...searchGridProps } /> : <Home /> }
                </div>                
                <Footer />
            </div>
        )
    }
}