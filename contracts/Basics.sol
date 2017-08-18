pragma solidity ^0.4.4;

contract Basics {

	// name of the ninja
	string name;

	// owner of the contract
	address owner;

	event changeName(string new_name);

	event changeOwner(address original_owner, address new_owner);

	modifier ownerOnly(address n) {
		// owner must be contract owner
		require(msg.sender == owner);
		// new owner cannot be same address
		require(msg.sender != n);
		_;
	}

	function Basics() {
		name = 'Satoshi Nakamoto';
		owner = msg.sender;
	}

	function getName() constant returns(string) {
		return name;
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