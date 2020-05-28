import React, { Component } from 'react';
import Home from './Home';
import Header from './Header';
import SearchInput from './SearchInput';
import Footer from './Footer';
import SearchGrid from './SearchGrid';
import Album from './Types/Album';

interface IState {
    data: {
        response: Album[],
        responseCount: number
    },
    query: string,
    searching: boolean,
    itemsPerPage: number,
    pageNumber: number
}

interface IProps {
    pageNumber: number
}

export default class Layout extends Component<IProps, IState> {
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
            fetchItemsPerPageCount: this.state.itemsPerPage,
            fetchPageNumber: this.fetchPageNumber,
            fetchSearchData: this.fetchSearchData
        }

        return (
            <div className='m-3'>
                <div className='d-flex justify-content-between'>
                    <Header />
                    <SearchInput 
                        pageNumber={this.state.pageNumber}
                        fetchSearchData={this.fetchSearchData}
                        fetchSearchQuery={this.fetchSearchQuery}
                        fetchItemsPerPageCount={this.fetchItemsPerPageCount} />
                </div>
                { this.state.searching ? <SearchGrid { ...searchGridProps } /> : <Home /> }
                <Footer />
            </div>
        )
    }
}