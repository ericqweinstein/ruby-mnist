import React, { Component } from 'react'

import Button from './Button.js'
import EditableCanvas from './EditableCanvas.js'
import Prediction from './Prediction.js'

class App extends Component {
  constructor() {
    super();

    this.state = {
      canvas: null,
      ctx: null,
      prediction: ''
    };

    this.submit = this.submit.bind(this);
    this.clear = this.clear.bind(this);
  }

  componentDidMount() {
    let can = document.getElementById('can');

    this.setState({
      canvas: can,
      ctx: can.getContext('2d')
    });
  }

  clear() {
    let canvasClear = this.refs.editableCanvas.clear;
    canvasClear();
  }

  submit() {
    this.setState({
      prediction: '...'
    });

    fetch('/submit', {
      method: 'POST',
      body: this.state.canvas.toDataURL('image/png')
    }).then(response => {
      return response.json();
    }).then(j => {
      this.setState({
        prediction: j.prediction
      });
    });
  }

  render() {
    let canvasStyle = {
      border: '2px solid'
    };

    return(
      <div>
        <EditableCanvas canvas={this.state.canvas} ctx={this.state.ctx} ref='editableCanvas' />
        <Prediction number={this.state.prediction} />
        <div>
          <Button onClick={this.submit} value='Submit' />
          <Button onClick={this.clear} value='Clear' />
        </div>
      </div>
    );
  }
}

export default App;
