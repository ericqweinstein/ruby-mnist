import React, { Component } from 'react'

class EditableCanvas extends Component {
  constructor(props) {
    super(props);

    this.state = {
      currX: 0,
      currY: 0,
      dotFlag: false,
      flag: false,
      height: 280,
      prevX: 0,
      prevY: 0,
      width: 280,
      x: 'black',
      y: 6
    };

    this.clear = this.clear.bind(this);
  }

  componentDidMount() {
    let can = document.getElementById('can');

    can.addEventListener('mousemove', e => {
      this.findPosition('move', e)
    }, false);

    can.addEventListener('mousedown', e => {
      this.findPosition('down', e)
    }, false);

    can.addEventListener('mouseup', e => {
      this.findPosition('up', e)
    }, false);

    can.addEventListener('mouseout', e => {
      this.findPosition('out', e)
    }, false);

    this.setState({
      canvas: can,
      ctx: can.getContext('2d')
    });
  }

  componentWillUnmount() {
    let can = this.state.canvas;

    can.removeEventListener('mousemove', this.findPosition);
    can.removeEventListener('mousedown', this.findPosition);
    can.removeEventListener('mouseup', this.findPosition);
    can.removeEventListener('mouseout', this.findPosition);
  }

  clear() {
    this.state.ctx.clearRect(0, 0, this.state.height, this.state.width);
  }

  draw() {
    this.state.ctx.beginPath();
    this.state.ctx.moveTo(this.state.prevX, this.state.prevY);
    this.state.ctx.lineTo(this.state.currX, this.state.currY);
    this.state.ctx.strokeStyle = this.state.x;
    this.state.ctx.lineWidth = this.state.y;
    this.state.ctx.stroke();
    this.state.ctx.closePath();
  }

  findPosition(res, e) {
    if (res === 'down') {
      this.setState({
        prevX: this.state.currX,
        prevY: this.state.currY,
        currX: e.clientX - this.state.canvas.offsetLeft,
        currY: e.clientY - this.state.canvas.offsetTop,
        flag: true,
        dotFlag: true
      });

      if (this.state.dotFlag) {
        this.state.ctx.beginPath();
        this.state.ctx.fillStyle = this.state.x;
        this.state.ctx.fillRect(this.state.currX, this.state.currY, 2, 2);
        this.state.ctx.closePath();
        this.setState({
          dotFlag: false
        });
      }
    }

    if (res === 'up' || res === 'out') {
      this.setState({
        flag: false
      });
    }

    if (res === 'move' && this.state.flag) {
      this.setState({
        prevX: this.state.currX,
        prevY: this.state.currY,
        currX: e.clientX - this.state.canvas.offsetLeft,
        currY: e.clientY - this.state.canvas.offsetTop
      });

      this.draw();
    }
  }

  render() {
    let canvasStyle = {
      border: '2px solid'
    };

    return(
      <canvas
        id='can'
        height={this.state.height}
        width={this.state.width}
        style={canvasStyle}>
      </canvas>
    );
  }
}

export default EditableCanvas;
