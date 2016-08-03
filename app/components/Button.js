import React, { Component } from 'react'

class Button extends Component {
  constructor() {
    super();
  }

  render() {
    let buttonStyle = {
      backgroundColor: '#337ab7',
      border: '1px solid #2e6da4',
      borderRadius: '5px',
      color: 'white',
      cursor: 'pointer',
      display: 'inline-block',
      fontFamily: 'sans-serif',
      height: '40px',
      lineHeight: '40px',
      margin: '0 5px 0 auto',
      textAlign: 'center',
      width: '80px'
    };

    return(
      <div onClick={this.props.onClick} style={buttonStyle}>
        {this.props.value}
      </div>
    );
  }
}

export default Button;
