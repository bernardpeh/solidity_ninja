import React, { Component } from 'react';
import './App.css';
import AddProject from './AddProject';

class App extends Component {
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h1>Crowdsale Example</h1>
        </div>
        <p className="App-intro">
          <AddProject />
        </p>
      </div>
    );
  }
}

export default App;
