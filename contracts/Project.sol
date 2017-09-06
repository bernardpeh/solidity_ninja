pragma solidity ^0.4.4;

contract Project {

	struct PStruct {
		address owner;
		// exercise: why can't we use string here?
		bytes32 name;
		bytes32 description;
		uint dueBlock;
		uint fundingCap;
		uint initBlock;
		mapping(address => uint) funders;
	}

	PStruct ps;

	// constructor
	// need to enforce byte32 else haywire happens
	function Project(address _owner, bytes32 _name, bytes32 _description, uint _dueBlock, uint _fundingCap) {
		ps.owner = _owner;
		ps.name = _name;
		ps.description = _description;
		ps.dueBlock = _dueBlock;
		ps.fundingCap = _fundingCap;
		// note it is also possible to use block.timestamp in utc
		ps.initBlock = block.number;
	}

	// allows project owner to update project name and desc only
	function updateStruct(address _owner, bytes32 _name, bytes32 _description) {
		require(_owner == ps.owner);
		ps.name = _name;
		ps.description = _description;
	}

	// for project info
	function getProjectInfo() returns (address, bytes32, bytes32, uint, uint, uint) {
		return (ps.owner, ps.name, ps.description, ps.dueBlock, ps.fundingCap, getBalance());
	}

	// allow anyone to fund the project
	function fund(address _sender) payable returns (uint) {

		// if deadline is over, kill project
		if (block.number > ps.initBlock + ps.dueBlock) {
			kill();
		}

		// if funding limit is reached, kill project
		if (getBalance() >= ps.fundingCap) {
			kill();
		}

		// user cannot fund 0 ether
		require(msg.value > 0);

		// update funders's amt
		ps.funders[_sender] += msg.value;

		// return total funder's amount
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
			// reset funds to 0
			ps.funders[_funder] = 0;
		}
	}

	// kill contract and payout
	function kill() internal {
		selfdestruct(ps.owner);
	}

	// get current contract balance
	function getBalance() returns (uint) {
		return this.balance;
	}

}