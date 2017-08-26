var ManageProject = artifacts.require("./ManageProject.sol");

module.exports = function(deployer) {
  // deployer.deploy(Project);
  // deployer.link(Project, ManageProject);
  deployer.deploy(ManageProject);
};