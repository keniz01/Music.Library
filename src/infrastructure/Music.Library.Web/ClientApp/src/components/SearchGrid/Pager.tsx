import React, { Component } from 'react';
import SearchAPI from '../Services/SearchServiceApi';

interface IProps {
    itemsPerPage: number,
    totalItems: number,
    fetchPageNumber: any,
    fetchSearchData: any,
    searchQuery: string
}

export default class Pager extends Component<IProps> {

    constructor(props: any) {
        super(props);  
        this.handleSelectedPage = this.handleSelectedPage.bind(this);
    }

    handleSelectedPage(e: any) {
        var pageNumber = Number(e.target.innerText);

        this.props.fetchPageNumber(pageNumber);

        SearchAPI.fetchSearchResults(this.props.searchQuery, 
            pageNumber, this.props.itemsPerPage)
                .then(data => {
                    this.setState({ data: data }, this.props.fetchSearchData(data));
                });
    }

    renderPagination() {
        const pageCount = Math.ceil(this.props.totalItems / this.props.itemsPerPage) || 0;
        const numberOfPages = Array.from(Array(pageCount).keys()).map(i => ++i);
        
        if(numberOfPages.length > 1) {
            return (
                <div className="text-center">
                    <ul className='list-inline'>
                        {numberOfPages.map(page => {
                            return (
                                <li className='list-inline-item' key={page}>
                                    <a className='text-decoration-none' href="#!" onClick={this.handleSelectedPage}> {page} </a>
                                </li>
                            )
                        })}                    
                    </ul>
                </div>
            )
        }

        return null;
    }

    render() {
        return (
            <div>
                {this.renderPagination()}
            </div>           
        )
    }
} 