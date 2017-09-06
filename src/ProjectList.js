import React, { Component } from 'react'
import FundProject from './FundProject'

class ProjectList extends Component {

  constructor(props) {
    super(props)
  }

  render() {
    return (
      <div className="list">
        <table>
          <thead>
            <tr>
              <th>Projects</th><th>Date due from now (in Blocks)</th><th>Funded (in eth)</th><th>Fund Project (in eth)</th>
            </tr>
          </thead>
          <tbody>
            {
              this.props.projectList.map((v,k) => {
                if (k == 0) {
                  return;
                }
                return (
                  <tr key={k}>
                    <td>Owner: {v.address}<br/>Project Name: {v.name}<br/>Description: {v.description}<br/>Funding Limit: {v.funding} ethers</td><td>{v.due}</td>
                    <td>
                      {v.balance}
                    </td>
                    <td>
                      <FundProject id={k} web3={this.props.web3}/>
                    </td>
                  </tr>
                )
              })
            }
          </tbody>
        </table>
      </div>
    );
  }
}

export default ProjectList