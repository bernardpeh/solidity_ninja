pragma solidity ^0.4.4;

contract Project {

	struct PStruct {

		address owner;
		// exercise: why can't we use string here?
		bytes32 name;
		bytes32 description;
		uint deadline;
		mapping(address => uint) funders;
	}

	PStruct ps;

	// constructor
	function Project(address _owner, bytes32 _name, bytes32 _description, uint _deadline) {
		ps.owner = _owner;
		ps.name = _name;
		ps.description = _description;
		ps.deadline = _deadline;
	}

	// get struc values
	function getStruct() returns (address, bytes32, bytes32, uint) {
		return (ps.owner, ps.name, ps.description, ps.deadline);
	}

	// allows project owner to update project name and desc only
	function updateStruct(address _owner, bytes32 _name, bytes32 _description) {
		require(_owner == ps.owner);
		ps.name = _name;
		ps.description = _description;
	}

	// kill contract and payout
	function kill() internal {
		selfdestruct(ps.owner);
	}

	// allow anyone to fund the project
	function fund(address _sender) payable returns (uint) {
		// user cannot fund 0 ether
		require(msg.value > 0);
		ps.funders[_sender] += msg.value;
		return ps.funders[_sender];
	}

	// get funder's amount so far
	function getFunder(address _funder) returns (uint) {
		return 	ps.funders[_funder];
	}

	// refund funder
	function refund(address _funder) payable {
		// if there are funds, transfer
		if (ps.funders[_funder] > 0) {
			_funder.transfer(ps.funders[_funder]);
		}
	}

	// get current contract balance
	function getBalance() returns (uint) {
		return this.balance;
	}
}