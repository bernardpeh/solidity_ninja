pragma solidity ^0.4.4;

import "./DateTimeAPI.sol";

contract GetDateTime {

    uint timestamp = 1503282547;
    uint public year;
    uint public day;
    uint public month;
    // address of deployed datetime library. Use your own
    address datetime = 0xa63faa64411daad940c8c83bfdcb54f462cd8dfe;
    DateTimeAPI dt = DateTimeAPI(datetime);

    function GetDateTime() {
        year = dt.getYear(timestamp);
        month = dt.getMonth(timestamp);
        day = dt.getDay(timestamp);
    }
}

// get year, should get 2017
// GetDateTime.deployed().then(function(ins){ins.year.call().then(function(val){console.log(val.toString())})})

// get month, should get 8
// GetDateTime.deployed().then(function(ins){ins.month.call().then(function(val){console.log(val.toString())})})

// get day, should get 21
// GetDateTime.deployed().then(function(ins){ins.day.call().then(function(val){console.log(val.toString())})})