import React, { Component } from 'react'
import './App.css'
import getWeb3 from './utils/getWeb3'
import AddProject from './AddProject'
import ProjectList from './ProjectList'
import ManageProjectContract from '../build/contracts/ManageProject.json'

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
      projectCounter: 0,
      projectList: []
    }
    this.setProjectCounter = this.setProjectCounter.bind(this)
    this.initProjectList = this.initProjectList.bind(this)
  }

  componentWillMount() {
    getWeb3
    .then(results => {
      this.setState({web3: results.web3})
      // web3 loaded, we can instantiate contract.
      this.getBalance()
      this.initProjectList()
    })
    .catch(() => {
      console.log('Error finding web3.')
    })
  }

  getBalance() {
    // Get accounts if account is ready
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

  setProjectCounter(counter) {
    this.getBalance()
    this.setState({projectCounter: counter})
    this.initProjectList();
  }

  initProjectList() {
    const contract = require('truffle-contract')
    const manageProject = contract(ManageProjectContract)
    manageProject.setProvider(this.state.web3.currentProvider)

    manageProject.deployed().then(function (ins) {
      var project_ins = ins;

      // get project counter
      project_ins.project_counter.call().then((res) => {
        console.log('project number is '+res.c[0])
        return res.c[0]
      }).then((res) => {
        for (var i=0; i < res+1; i++) {
          project_ins.getStruct.call(i).then((res) => {
            this.setState({projectList: [...this.state.projectList, {'address': res[0], 'name': res[1], 'description': res[2], 'due': res[3].c[0], 'funding': res[4].c[0]}]})
          })
        }
      })

    }.bind(this))
  }

  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h1>Crowdsale Example</h1>
        </div>
        <div className="App-intro">
          <AddProject state={this.state} setProjectCounter={this.setProjectCounter}/>
          <ProjectList projectList={this.state.projectList} web3={this.state.web3} projectCounter={this.state.projectCounter}/>
        </div>
      </div>
    );
  }
}

export default App;
