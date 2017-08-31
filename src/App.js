import React, { Component } from 'react'
import './App.css'
import getWeb3 from './utils/getWeb3'
import ManageProjectContract from '../build/contracts/ManageProject.json'
import AddProject from './AddProject'

import './css/oswald.css'
import './css/open-sans.css'
import './css/pure-min.css'
import './App.css'

class App extends Component {

  constructor(props) {
    super(props)
    this.state = {
      web3: null,
      address: null,
      balance: null,
    }
  }

  componentWillMount() {
    getWeb3
    .then(results => {
      this.setState({web3: results.web3})
      // web3 loaded, we can instantiate contract.
      this.instantiateContract()
    })
    .catch(() => {
      console.log('Error finding web3.')
    })
  }

  instantiateContract() {
    console.log('initiating contract...');
    const contract = require('truffle-contract')
    const manageProject = contract(ManageProjectContract)

    // manageProject.setProvider(this.state.web3.currentProvider)
    // Get accounts.
    this.state.web3.eth.getAccounts((err, accounts) => {
      if (err) {
        console.log(err);
      }

      this.setState({address: this.state.web3.eth.accounts[0], balance: this.state.web3.eth.accounts[0].balance})
      // return manageProject;
    }).catch(err => {
      console.log('error '+err.msg)
    })
    console.log('address is '+this.state.address);
    console.log('balance is '+this.state.balance);
  }

  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h1>Crowdsale Example</h1>
        </div>
        <p className="App-intro">
          <AddProject address={this.state.address} balance={this.state.balance}/>
        </p>
      </div>
    );
  }
}

export default App;
