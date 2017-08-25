pragma solidity ^0.4.4;

import "./Project.sol";

contract ManageProject {

	mapping(uint => Project) public projects;
	uint public project_counter;
	// creator of this project
	address admin;

	event logCreatedProject(address _project_address, address _owner, bytes32 _projectName, bytes32 _projectDesc, uint _dueBlock, uint _fundingCap);
	event logUpdatedProject(uint _id, address _owner, bytes32 _name, bytes32 _description);
	event logDeletedProject(uint _id);
	event logFundProject(uint _id, address _funder, uint _value);
	event logRefundProject(uint _id, address _funder, uint _value);

	// constructor
	function ManageProject() {
		admin = msg.sender;
	}

	// allows anyone to create new project
	function createProject(bytes32 _name, bytes32 _desc, uint _dueBlock, uint _fundingCap) {
		logCreatedProject(contract_address, msg.sender, _name, _desc, _dueBlock, _fundingCap);
		address contract_address = new Project(msg.sender, _name, _desc, _dueBlock, _fundingCap);
		project_counter++;
		projects[project_counter] = Project(contract_address);
	}

	// converts bytes32 to string
	function bytes32ToString(bytes32 x) constant returns (string) {
		bytes memory bytesString = new bytes(32);
		uint charCount = 0;
		for (uint j = 0; j < 32; j++) {
			byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
			if (char != 0) {
				bytesString[charCount] = char;
				charCount++;
			}
		}
		bytes memory bytesStringTrimmed = new bytes(charCount);
		for (j = 0; j < charCount; j++) {
			bytesStringTrimmed[j] = bytesString[j];
		}
		return string(bytesStringTrimmed);
	}

	// project owner can update their own projects - name and desc only.
	function updateProjectStruct(uint _id, bytes32 _name, bytes32 _description) {
		projects[_id].updateStruct(msg.sender, _name, _description);
		logUpdatedProject(_id, msg.sender, _name, _description);
	}

	// only admin can delete project
	function deleteProjectStruct(uint _id) returns (bool) {
		require(msg.sender == admin);
		delete projects[_id];
		logDeletedProject(_id);
		return true;
	}

	// returns total funded
	function fund(uint _id) payable returns (uint) {
		// note the syntax for sending payment from a contract in wei
		uint total = projects[_id].fund.value(msg.value)(msg.sender);
		// log fund
		logFundProject(_id, msg.sender, msg.value);
		return total;
	}

	function refund(uint _id) payable {
		projects[_id].refund(msg.sender);
		// log refund
		logRefundProject(_id, msg.sender, msg.value);
	}

	// get funder
	function getFunder(uint _id, address _funder) returns (uint) {
		return projects[_id].getFunder(_funder);
	}

	// returns project current balance
	function getProjectBalance(uint _id) returns (uint) {
		return projects[_id].getBalance();
	}

	function getStruct(uint _id) returns (address, string, string, uint, uint) {
		address _owner;
		bytes32 _name;
		bytes32 _desc;
		uint  _dueBlock;
		uint _fundingCap;

		(_owner, _name, _desc, _dueBlock, _fundingCap) = projects[_id].getStruct();
		return (_owner, bytes32ToString(_name), bytes32ToString(_desc), _dueBlock, _fundingCap);
	}

	// current project should not store any money. so it should always be 0.
	function getContractBalance() returns (uint){
		return this.balance;
	}

	// fallback. do nothing for now.
	function () {
	}

}

// create 2 projects with cap limit of 5 ether - should see new project created
// ManageProject.deployed().then(function(ins){ins.createProject("first project","desc 1", 200, 5000).then(function(val) {val.logs[args]})})
// ManageProject.deployed().then(function(ins){ins.createProject("second project","desc 2", 300, 60000).then(function(val) {console.log(val)})})

// get project_counter
// ManageProject.deployed().then(function(ins){ins.project_counter.call().then(function(val) {console.log(val.toString())}) })

// see project 2 address
// ManageProject.deployed().then(function(ins){ins.projects.call(2).then(function(val){console.log(val)})})

// get project 2 struct.
// ManageProject.deployed().then(function(ins){ins.getStruct.call(2).then(function(val){console.log(val.toString())})})

// current acct 3 balance
// web3.fromWei(web3.eth.getBalance(web3.eth.accounts[3]));

// fund 3 ether to project 2 from acct3
// ManageProject.deployed().then(function(ins){ins.fund.sendTransaction(2, {from: web3.eth.accounts[3], value: 3*10**18}).then(function(val){console.log(val)})})

// get acct3 balance. should be 3 ether.
// ManageProject.deployed().then(function(ins){ins.getFunder.call(2, web3.eth.accounts[3]).then(function(val){console.log(val.toString())})})

// get project 2 balance. Should be 3 ether.
// ManageProject.deployed().then(function(ins){ins.getProjectBalance.call(2).then(function(val){console.log(val.toString())})})

// get current Contract Balance. Should be 0.
// ManageProject.deployed().then(function(ins){ins.getContractBalance.call().then(function(val){console.log(val.toString())})})

// acct 3 wants a refund
// ManageProject.deployed().then(function(ins){ins.refund(2, {from: web3.eth.accounts[3]}).then(function(val){console.log(val)})})

// iterator - https://github.com/szerintedmi/solidity-itMapsLib