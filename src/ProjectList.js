import React, { Component } from 'react'

class ProjectList extends Component {

  constructor(props) {
    super(props)
  }

  render() {
    return (
      <div>
        <table>
          <thead>
            <tr>
              <th>Owner</th><th>Project Name</th><th>Project Description</th><th>Due In (Blocks)</th><th>Funding Limit (ethers)</th>
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
                    <td>{v.address}</td><td>{v.name}</td><td>{v.description}</td><td>{v.due}</td><td>{v.funding}</td>
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