pragma solidity ^0.4.4;

import "./GetDateTime.sol";

contract GetUpgradedDateTime is GetDateTime {

	uint public hr;
	uint public min;

	function GetUpgradedDateTime() {

		hr = dt.getHour(timestamp);
		min = dt.getMinute(timestamp);
	}
}

// get year, should get 2017
// GetUpgradedDateTime.deployed().then(function(ins){ins.year.call().then(function(val){console.log(val.toString())})})

// get month, should get 8
// GetUpgradedDateTime.deployed().then(function(ins){ins.month.call().then(function(val){console.log(val.toString())})})

// get day, should get 21
// GetUpgradedDateTime.deployed().then(function(ins){ins.day.call().then(function(val){console.log(val.toString())})})

// get hr, should be 2
// GetUpgradedDateTime.deployed().then(function(ins){ins.hr.call().then(function(val){console.log(val.toString())})})

// get min, should be 29
// GetUpgradedDateTime.deployed().then(function(ins){ins.min.call().then(function(val){console.log(val.toString())})})