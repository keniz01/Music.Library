import React from 'react';

export default class DashBoardMetricsGrid extends React.Component {
    render() {
        const {totalArtists, totalAlbums, totalRecords, totalLabels, totalGenres } = this.props.statistics;
        return (
            <div className="dash-card-area">
                <div className="dash-card">
                    <div className="container">
                        <div><b>Total Artist</b></div> 
                        <div>{totalArtists}</div>
                    </div>
                </div>
                <div className="dash-card">
                    <div className="container">
                        <div><b>Total Albums</b></div> 
                        <div>{totalAlbums}</div>
                    </div>
                </div>  
                <div className="dash-card">
                    <div className="container">
                        <div><b>Total Records</b></div> 
                        <div>{totalRecords}</div>
                    </div>
                </div>  
                <div className="dash-card">
                    <div className="container">
                        <div><b>Total Labels</b></div> 
                        <div>{totalLabels}</div>
                    </div>
                </div>  
                <div className="dash-card">
                    <div className="container">
                        <div><b>Total Genres</b></div> 
                        <div>{totalGenres}</div>
                    </div>
                </div>                
            </div>
        )
    }
}