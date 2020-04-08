import React from 'react';

export default class Pager extends React.Component {
    render() {

        const display = (pageNumbers) => {
            if(pageNumbers < 2)
            {
                return(
                    <div></div>
                )                
            } else {
                return (
                    <div className="pager">
                        <ul>
                            {pageNumbers.map(pageNumber => {
                                return (
                                    <li key={pageNumber}>
                                        <a 
                                            href='!#' 
                                            onClick={() => this.props.handlePageChange(pageNumber)}>{pageNumber}
                                        </a>
                                    </li>
                                )
                            })}                    
                        </ul>
                    </div>
                )
            }
        }

        const pageCount = Math.ceil(this.props.totalItems / this.props.itemsPerPage) || 0;
        const pageNumbers = Array.from(Array(pageCount).keys()).map(i => ++i);

        return (
            <div>
                {display(pageNumbers) }
            </div>           
        )
    }
} 