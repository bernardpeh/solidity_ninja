var Basics = artifacts.require("./Basics.sol");
var EventSales = artifacts.require("./EventSales.sol");

module.exports = function(deployer) {
  deployer.deploy(Basics);
  deployer.deploy(EventSales);
};
