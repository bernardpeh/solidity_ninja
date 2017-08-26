var GetDateTime = artifacts.require("./GetDateTime.sol");
var GetUpgradedDateTime = artifacts.require("./GetUpgradedDateTime.sol");

module.exports = function(deployer) {
    deployer.deploy(GetDateTime);
    deployer.deploy(GetUpgradedDateTime);
};