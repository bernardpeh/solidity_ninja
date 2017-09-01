import React, { Component } from 'react'
import './App.css'
import getWeb3 from './utils/getWeb3'
import AddProject from './AddProject'
import ProjectList from './ProjectList'

import './css/oswald.css'
import './css/open-sans.css'
import './css/pure-min.css'
import './App.css'

class App extends Component {

  constructor(props) {
    super(props)
    this.state = {
      web3: '',
      address: '',
      balance: '',
      projectList: []
    }
  }

  componentWillMount() {
    getWeb3
    .then(results => {
      this.setState({web3: results.web3})
      // web3 loaded, we can instantiate contract.
      this.getBalance()
    })
    .catch(() => {
      console.log('Error finding web3.')
    })
  }

  getBalance() {
    // Get accounts.
    this.state.web3.eth.getAccounts((err, accounts) => {
      if (err) {
        console.log(err);
      }
      else {
        this.state.web3.eth.getBalance(this.state.web3.eth.accounts[0], (err1, res) => {
          if (err1) {
            console.log(err1);
          }
          else {
            this.setState({balance: this.state.web3.fromWei(res.toNumber())})
          }
        })

        this.setState({address: this.state.web3.eth.accounts[0]})
        // return manageProject;
      }
    })
  }

  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h1>Crowdsale Example</h1>
        </div>
        <div className="App-intro">
          <AddProject state={this.state} />
          <ProjectList projectList={this.state.projectList}/>
        </div>
      </div>
    );
  }
}

export default App;
