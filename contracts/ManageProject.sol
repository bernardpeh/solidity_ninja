pragma solidity ^0.4.4;

import "./Project.sol";

contract ManageProject {

	mapping(uint => Project) public projects;
	uint public project_counter;
	// creator of this project
	address admin;

	event logCreatedProject(address project_address, address owner, bytes32 project_name, bytes32 project_desc, uint deadline);
	event logUpdatedProject(uint _id, address _owner, bytes32 _name, bytes32 _description);
	event logDeletedProject(uint _id);
	event logFundProject(uint _id, address _funder, uint _value);

	// constructor
	function ManageProject() {
		admin = msg.sender;
	}

	// allows anyone to create new project
	function createProject(bytes32 _name, bytes32 _desc, uint _deadline) {
		address contract_address = new Project(msg.sender, _name, _desc, _deadline);
		project_counter++;
		projects[project_counter] = Project(contract_address);
		logCreatedProject(contract_address, msg.sender, _name, _desc, _deadline);
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

	// get project struct anytime
	function getProjectStruct(uint _id) returns (address, string, string, uint) {
		address _owner;
		bytes32 _name;
		bytes32 _desc;
		uint _deadline;
		(_owner, _name, _desc, _deadline) = projects[_id].getStruct();
		string memory _sname = bytes32ToString(_name);
		string memory _sdesc = bytes32ToString(_desc);
		return (_owner, _sname, _sdesc, _deadline);
	}

	// project owner can update their own projects
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
		// note the syntax for sending payment from a contract
		logFundProject(_id, msg.sender, msg.value);
		// whats the problem with this?
		return projects[_id].fund.value(msg.value - 500000)(msg.sender);
	}

	// get funder
	function getFunder(uint _id, address _funder) returns (uint) {
		return projects[_id].getFunder(_funder);
	}

	// returns project current balance
	function getProjectBalance(uint _id) returns (uint) {
		projects[_id].getBalance();
	}

	// current project should not store any money. so it should always be 0.
	function getContractBalance() returns (uint){
		return this.balance;
	}

	// fallback. sorry dont accept free money.
	function () {
	}

}

// create 2 projects - should see new project created
// ManageProject.deployed().then(function(ins){ins.createProject('first project', 'this is just a plain description 1', 10).then(function(val) {console.log(val)})})
// ManageProject.deployed().then(function(ins){ins.createProject('second project', 'this is just a plain description 2', 20).then(function(val) {console.log(val)})})

// get project_counter
// ManageProject.deployed().then(function(ins){ins.project_counter.call().then(function(val) {console.log(val.toString())}) })

// see project 2 address
// ManageProject.deployed().then(function(ins){ins.projects.call(2).then(function(val){console.log(val)})})

// current acct 3 balance
// web3.fromWei(web3.eth.getBalance(web3.eth.accounts[3]));

// fund project 2 from account 3
// ManageProject.deployed().then(function(ins){ins.fund.sendTransaction(2, {from: web3.eth.accounts[3], value: 8300000000000000000}).then(function(val){console.log(val)})})

// get funder balance
// ManageProject.deployed().then(function(ins){ins.getFunder.call(2, web3.eth.accounts[3]).then(function(val){console.log(val)})})

// get project 2 balance. Should be 2200.
// ManageProject.deployed().then(function(ins){ins.getProjectBalance.call(2).then(function(val){console.log(val)})})

// get current Contract Balance. Should be 0.
// ManageProject.deployed().then(function(ins){ins.getContractBalance.call().then(function(val){console.log(val)})})

// iterator - https://github.com/szerintedmi/solidity-itMapsLib