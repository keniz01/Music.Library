import React, { Component } from 'react';
import SearchServiceApi from '../Services/SearchServiceApi';
import IProps from './IProps';
import IState from './IState';

export default class SearchInput extends Component<IProps, IState> {

    static displayName  = SearchInput.name

    constructor(props: any) {
        super(props);

        this.state = {
            query: '',
            pageNumber: 1,
            itemsPerPage: 10,
            data: {}
        };

        this.handleSubmit = this.handleSubmit.bind(this);
        this.handleItemsPerPage = this.handleItemsPerPage.bind(this);
        this.handleOnChange = this.handleOnChange.bind(this);
    }

    handleOnChange(e: any) {
        this.setState({ query: e.target.value }); 
    }

    handleItemsPerPage(e: any) {
        var itemsPerPage: number = Number(e.target.value)
        this.setState({ itemsPerPage: itemsPerPage });

        if(this.state.query) {
            SearchServiceApi.fetchSearchResults(this.state.query, 1, itemsPerPage)
                .then(data => {
                    console.log('Data: ', data);
                    this.setState({ data: data }, this.props.fetchSearchData(data));
                });
            this.props.fetchItemsPerPageCount(itemsPerPage);
            console.log('Items: ', itemsPerPage);
        }      
    }

    handleSubmit(e: any) {

        const isValidKeyCode: boolean = e.charCode === 13 || e.keyCode === 13 || e.which === 13; 
        
        if(isValidKeyCode) {            
            if(this.state.query) {                   
                SearchServiceApi.fetchSearchResults(this.state.query, 1, this.state.itemsPerPage)
                    .then(data => {
                        this.setState({ data: data }, this.props.fetchSearchData(data));
                    });
                
                this.props.fetchSearchQuery(this.state.query);                    
            }
        }
    }

    render() {
        return (
            <div className='search'>
                <input 
                    onKeyPress={ this.handleSubmit }
                    onChange={this.handleOnChange}
                    className='' 
                    type="text" 
                    id="searchTextInput" 
                    placeholder="Enter artist, album and/or track ..." />

                <select value={this.state.itemsPerPage} onChange={this.handleItemsPerPage}>                   
                    <option value='10'>10</option>
                    <option value='20'>20</option>
                    <option value='30'>30</option>
                    <option value='40'>40</option>
                    <option value='50'>50</option>
                </select>                    
            </div>
        )
    }
}