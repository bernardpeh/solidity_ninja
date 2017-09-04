import React, { Component } from 'react'
import ManageProjectContract from '../build/contracts/ManageProject.json'

class ProjectList extends Component {

  constructor(props) {
    super(props)
    this.state = {
      projectList: []
    }
  }

  initProjectList() {
    // get contract
    if (this.props.web3.currentProvider) {
      const contract = require('truffle-contract')
      const manageProject = contract(ManageProjectContract)
      manageProject.setProvider(this.props.web3.currentProvider)
      manageProject.deployed().then(function (ins) {
        var project_ins = ins;
        for (var i=0; i < this.props.projectCounter; i++) {
          project_ins.getStruct.call(i).then((res) => {
            this.state.projectList.push({'address': res[0], 'name': res[1], 'description': res[2], 'due': res[3].c[0], 'funding': res[4].c[0]})
          })
        }
        console.log(this.state.projectList)
      }.bind(this))
    }
  }

  render() {
    console.log('projectlist is rendered')
    this.initProjectList()
    return (
      <div>
        <p>
          This is the list
        </p>
      </div>
  );
  }
}

export default ProjectList