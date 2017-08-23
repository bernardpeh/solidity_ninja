pragma solidity ^0.4.4;

contract Project {

	struct PStruct {
		address owner;
		// exercise: why can't we use string here?
		bytes32 name;
		bytes32 description;
		uint deadline;
	}

	PStruct ps;

	modifier ownerOnly(address _owner) {
		require(_owner == ps.owner);
		_;
	}

	function Project(address _owner, bytes32 _name, bytes32 _description, uint _deadline) {
		ps.owner = _owner;
		ps.name = _name;
		ps.description = _description;
		ps.deadline = _deadline;
	}

	function getStruct() returns (address, bytes32, bytes32, uint) {
		return (ps.owner, ps.name, ps.description, ps.deadline);
	}

	// allows project owner to update project name and desc only
	function updateStruc(bytes32 _name, bytes32 _description) ownerOnly() returns (bool) {
		ps.name = _name;
		ps.description = _description;
	}
}