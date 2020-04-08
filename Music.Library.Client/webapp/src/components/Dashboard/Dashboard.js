import React from 'react';

export default class DashBoard extends React.Component {
    render() {
        const {totalArtists, totalAlbums, totalRecords, totalLabels, totalGenres } = this.props.statistics;
        return (
            <div className="dash-card-area">
                <div className="dash-card">
                    <div className="container">
                        <h4><b>Total Artist</b></h4> 
                        <p>{totalArtists}</p>
                    </div>
                </div>
                <div className="dash-card">
                    <div className="container">
                        <h4><b>Total Albums</b></h4> 
                        <p>{totalAlbums}</p>
                    </div>
                </div>  
                <div className="dash-card">
                    <div className="container">
                        <h4><b>Total Records</b></h4> 
                        <p>{totalRecords}</p>
                    </div>
                </div>  
                <div className="dash-card">
                    <div className="container">
                        <h4><b>Total Labels</b></h4> 
                        <p>{totalLabels}</p>
                    </div>
                </div>  
                <div className="dash-card">
                    <div className="container">
                        <h4><b>Total Genres</b></h4> 
                        <p>{totalGenres}</p>
                    </div>
                </div>                
            </div>
        )
    }
}