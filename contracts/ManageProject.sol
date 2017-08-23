pragma solidity ^0.4.4;

import "./Project.sol";

contract ManageProject {

	mapping(uint => Project) public projects;
	uint project_counter;

	event logCreatedProject(address project_address, address owner, bytes32 project_name, bytes32 project_desc, uint deadline);
	event logUpdatedProject();
	event logDeletedProject();

	function createProject(bytes32 _name, bytes32 _desc, uint _deadline) {
		address contract_address = new Project(msg.sender, _name, _desc, _deadline);
		project_counter++;
		projects[project_counter] = Project(contract_address);
		logCreatedProject(contract_address, msg.sender, _name, _desc, _deadline);
	}

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

	function updateProjectStruct(uint id, address _owner, bytes32 _name, bytes32 _description) returns (bool) {
		if (projects[_id].updateStruct(_owner, _name, _description)) {
			return true;
		}
		else {
			return false;
		}
	}

	// only admin can delete project
	function deleteProjectStruct(uint _id) returns (bool) {
		// question: what is the difference between msg.sender and tx.origin?
		require(msg.sender == tx.origin);
		delete projects[_id];
		return true;
	}
}

// create project - should see new project created
// ManageProject.deployed().then(function(ins){ins.createProject('hellow1 world', 'this is just a plain description', 50).then(function(val) {console.log(val)})})

// get project_counter
// ManageProject.deployed().then(function(ins){ins.project_counter.call().then(function(val) {console.log(val.toString())}) })

// see all project mappings
// ManageProject.deployed().then(function(ins){ins.projects.call().then(function(val){console.log(val)})})

// get project
// ManageProject.deployed().then(function(ins){ins.getProject(1).then(function(val){console.log(val)})})

// iterator - https://github.com/szerintedmi/solidity-itMapsLib