# Tutorial 3 - Libraries and Inheritance

Useful contracts can be deployed once and reused many times by others.

Create a contract called GetDateTime to use an [external datetime library](https://github.com/pipermerriam/ethereum-datetime) to get the day, month and year with a timestamp.

Create a child contract of GetDateTime called GetUpgradedDateTime to get hrs and mins as well.

## Business Rules

* GetDateTime should store the right day, month and year values with the unix timestamp of 1503282547.
* GetUpgradedDateTime should store the right day, month, yr, hr and mins value with the same unix timestamp 1503282547.

## Functional Test

* For GetDateTime contract, day should be 21, month should be 8, year should be 2017.
* For GetUpgradedDateTime, day should be 21, month should be 8, year should be 2017, hrs should be 2 and mins should be 29.

# References

* [Solidity Doc](https://solidity.readthedocs.io/en/develop/)
* [Truffle framework](http://truffleframework.com/docs/getting_started/contracts)
