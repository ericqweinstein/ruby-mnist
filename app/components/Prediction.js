import React, { Component } from 'react'

class Prediction extends Component {
  constructor() {
    super();
  }

  render() {
    let predictionStyle = {
      float: 'right',
      fontFamily: 'sans-serif',
      fontSize: '100px'
    };

    let numberStyle = {
      color: '#337ab7'
    };

    return(
      <div style={predictionStyle}>
        Prediction: <span style={numberStyle}>{this.props.number}</span>
      </div>
    );
  }
}

export default Prediction;
