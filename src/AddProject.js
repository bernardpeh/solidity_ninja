import React, { Component } from 'react';

class AddProject extends Component {

  constructor(props) {
    super(props)
  }

  render() {
    return (
      <div>
        <p>
          Your current wallet address: {this.props.address}, balance: {this.props.balance}
        </p>
        <label><strong>Create a new project</strong></label>
        <div><label>Project Name: </label><input name="name" /></div>
        <div><label>Project Description: </label><input name="name" /></div>
        <div><label>Project Due (in blocks): </label><input name="name" /></div>
        <div><label>Funding Cap (in ether): </label><input name="name" /></div>
        <div><input type="submit" /></div>
      </div>
    );
  }
}

export default AddProject