var SolidityNinja = artifacts.require("./SolidityNinja.sol");

module.exports = function(deployer) {
  deployer.deploy(SolidityNinja);
};
