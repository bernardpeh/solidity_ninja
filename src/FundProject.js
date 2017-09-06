import React, { Component } from 'react'
import ManageProjectContract from '../build/contracts/ManageProject.json'

class FundProject extends Component {

  constructor(props) {
    super(props)
    this.state = {
      fundedAmount: ''
    }
  }

  fundProject(e) {
    // dont submit the form.
    e.preventDefault()
    // get contract
    const contract = require('truffle-contract')
    const manageProject = contract(ManageProjectContract)
    manageProject.setProvider(this.props.web3.currentProvider)

    // lets do everything only if accounts is ready
    this.props.web3.eth.getAccounts((err, accounts) => {
      if (err) {
        console.log(err);
      }
      else {
        manageProject.deployed().then( function(ins) {
          var project_ins = ins;
          console.log('amt is '+this.state.fundedAmount)
          return project_ins.fund(this.props.id, {from: accounts[0], value: this.state.fundedAmount * Math.pow(10,18)})
            .then((res) => {
              // should receive a successful trans id
              return res
            })
            .catch((err) => {
              console.log(err)
            })
        }.bind(this))
      }
    })
  }

  setFund(e) {
    this.setState({fundedAmount: e.target.value})
  }

  render() {
    return (
      <form onSubmit={this.fundProject.bind(this)}>
        Amt in Ether: <input type="text" onChange={this.setFund.bind(this)} value={this.state.fundedAmount} /><br/><input type="submit"/>
      </form>
    )
  }
}

export default FundProject