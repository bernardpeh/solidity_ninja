pragma solidity ^0.4.4;

contract SolidityNinja {

	// name of the ninja
	string public name;

	// owner of the contract
	address owner;

	event changeName(string name);

	event changeOwner(address original_owner, address new_owner);

	modifier ownerOnly(address n) {
		// owner must be contract owner
		require(msg.sender == owner);
		// new owner cannot be same address
		require(msg.sender != n);
		_;
	}

	function SolidityNinja() {
		name = 'Satoshi Nakamoto';
		owner = msg.sender;
	}

	function getOwner() constant returns(address) {
		return owner;
	}

	function setName(string n) {
		changeName(n);
		name = n;
	}

	function setOwner(address n) ownerOnly(n) {
		changeOwner(msg.sender, n);
		owner = n;
	}
}