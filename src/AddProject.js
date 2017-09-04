import React, { Component } from 'react';
import ManageProjectContract from '../build/contracts/ManageProject.json'

class AddProject extends Component {

  constructor(props) {
    super(props)
    this.state = {
      name: '',
      description: '',
      due: '',
      cap: ''
    }
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  setName(e) {
    this.setState({name: e.target.value})
  }

  setDescription(e) {
    this.setState({description: e.target.value})
  }

  setDue(e) {
    this.setState({due: e.target.value})
  }

  setCap(e) {
    this.setState({cap: e.target.value})
  }

  handleSubmit(e) {
    // dont submit the form.
    e.preventDefault()
    // get contract
    const contract = require('truffle-contract')
    const manageProject = contract(ManageProjectContract)
    manageProject.setProvider(this.props.state.web3.currentProvider)
    var name = this.state.name
    var description = this.state.description
    var due = this.state.due
    var cap = this.state.cap

    manageProject.deployed().then( function(ins) {
      var project_ins = ins;

      return project_ins.createProject(name, description, due, cap)
      .then((res) => {
        // get project count
        return project_ins.project_counter.call()
      })
      .then ((res) => {
        // project counter atm
       this.props.setProjectCounter(res.c[0])
      })
      .catch((err) => {
        console.log(err)
      })
    }.bind(this))

  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <p>
          Your current wallet address: {this.props.state.address}, balance: {this.props.state.balance}
        </p>
        <label><strong>Create a new project</strong></label>
        <label>Project Name (32 chars max): </label><input type="text" onChange={this.setName.bind(this)} value={this.state.name} /><br/>
        <label>Project Description (32 chars max): </label><input type="text" onChange={this.setDescription.bind(this)} value={this.state.description} /><br/>
        <label>Project Due (in blocks) (numbers only): </label><input type="text" onChange={this.setDue.bind(this)} value={this.state.due} /><br/>
        <label>Funding Cap (in ether) (numbers only): </label><input type="text" onChange={this.setCap.bind(this)} value={this.state.cap} /><br/>
        <input type="submit" />
      </form>
    );
  }
}

export default AddProject