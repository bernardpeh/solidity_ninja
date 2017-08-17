pragma solidity ^0.4.4;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SolidityNinja.sol";

contract TestSolidityNinja {

	SolidityNinja sn = SolidityNinja(DeployedAddresses.SolidityNinja());

	address accountOwner = 0x293da2ded324c4f5e335fe75f17afd1801736b21;

	event debugAddress(address val);

	function testGetOwner() {
		// bytes32 name = sn.name.call().then(function(v) {return v;});
		address owner = sn.getOwner();
		Assert.equal(owner, accountOwner, "Owner address should be correct.");
	}
}
