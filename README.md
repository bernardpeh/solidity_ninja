# About

Solidity Ninja is a series of tutorials that turn newbie ethereum solidity developers into ninja in 5 days.

We won't be able to cover everything in 5 days but enough to get you going.

Try to understand concepts rather than jumping into the syntax straight away. It would make life a lot easier when you start coding.

Solidity scripts are usually short but the emphasis is on security.

## Prerequisites

1. Install [truffle](https://github.com/trufflesuite/truffle)

2. Install [testrpc](https://github.com/ethereumjs/testrpc)

3. Install [ether explorer](https://github.com/etherparty/explorer)

3. git clone git@github.com:bernardpeh/solidity_ninja.git

## Quick start

1. In a new terminal, start testrpc
```
testrpc -m "enlist illness roast pair check danger drill noble dove repeat great margin"
```

You should get these newly generaeted accounts if your mnemonic seed above is correct.

```

==================
(0) 0x293da2ded324c4f5e335fe75f17afd1801736b21
(1) 0x028a966c9680f941faf58a9f293167280b6b1764
(2) 0xe18a29128d7336d6e3561a122e58fd9cc840b5fc
(3) 0x772ff6c576a3d8ad54f0f6e5558c7e0895a58968
(4) 0x31204f76910c0082cd271e02e41e131c43846e51
(5) 0x9b72ee15fa2d60666ef0347cde3c99438854b27b
(6) 0x786966540fa6643c77aa28cc4f28dd7c9adfc88a
(7) 0x85510a85a8f7c8e38779f4a124679650df1b5145
(8) 0x7eb114442c618b6b381a04d330abc7126efb0f0b
(9) 0x77dde6f9bc9c2a002cbc49d11dd3656e233a91ca

Private Keys
==================
(0) 1ae970c3f9ce3be299f23f226308d3207e78347d754accd4c0d396ddad4fbe60
(1) 5b7b24d7c3e3ec9efb14bec69886c1286cb986b4650d71be86cc59c67c896578
(2) b07c49666224e59ee668931be62be261f4fec22fc60cce8dbdf0431ae63261e9
(3) 7fd5dc85cf0a85fccb2a4c86eb6fbacc54b9d10d31933fa48f7d6f3ea931d10e
(4) 10d19fda38342c526b453ddd2c2115add95c4bf2eddef9d395b9b79ffbf7e272
(5) 560c1e23fc51786ccf7efa849b2a1a29d4f41367a61aa30d560cdf71ce337086
(6) 40446289a7d88982918ece6e82e5592c6c4d69e3d3d32714439454cea8a7afb6
(7) 232efe19c8406cbe5762170865bd95fbca20f90b3f6d22f528de3a78b26d3bb3
(8) c1cd9a4f1cfe72846b5422d5e99a6cd5542c7b4ad72de3b28385e1e0545b84b4
(9) 831b9ac6996aa20ff4f5622fb98fdda35ebc5412b5b05d2f95269f54fe9d8a06

```

2. In a new terminal, deploy contract into master branch

```
truffle migrate
```

# Tutorial 1 - Basics

## Objectives

Create a basic smart contract

Try coding it at https://remix.ethereum.org

## Business Rules:

* Contract should have an owner (name and address)
* Owner's name and address should be updatable.

## Unit Tests

* should get the right initial owner's name
* should get the right inital owner's address
* should set the name correctly
* should set acct1 as new owner
* should not set acct1 as new owner if owner is already acct1
* should not be able to set acct2 as new owner if owner is now acct0

# Tutorial 2 - Event Sales

## Objectives

Create a smart contract to sell tickets for a event.

Try coding it at https://remix.ethereum.org

Inspect transactions with eth explorer.

## Business Rules

* Number of tickets capped at 20.
* The event runs for 30 blocks(10 mins if each block is 20s).
* Price of each ticket is 10 ether. Buyer cannot pay less or more than that for each ticket.
* Contract holding amount should be easily available to anyone anytime.
* Buyer can cancel their payment and be refunded before the contract expires.
* Contract will be automatically terminated once the ticket is sold out and contract balance tranferred to the owner.
* Buyers cannot buy anymore tickets after the event has expired even if ticket is still not sold out.
* Alternatively, contract owner can terminate the contract manually after it has expired.
* The contract cannot be pre-maturely terminated otherwise.

## Unit Tests

* initial number of tickets should be 20.
* initial constant price should be 1 ether.
* initial owner should be acct0.
* should not allow successful purchase when acct1 purchase 21 tickets.
* should not allow successful purchase when acct1 pays 2 ether for 3 tickets.
* should allow successful purchase when acct1 pays 2 ether for 2 tickets and contract balance should be 2 ether and remaining tickets become 18;
* should not allow acct1 to refund 3 tickets.
* should allow acct1 to refund 1 ticket and contract balance should be 1 ether and remaining tickets become 19.
* should allow acct2 to send 2.5 ether to the contract and the contract balance should be 3.5 ether and total ticket is still 19.
* should allow acct3 to buy 19 tickets and contract should be destroyed (owner, ticket, price and buyers should be set to 0).
* acct0 should have 122.5 eth, acct1 have 99 ether and acct2 have 78.5 ether remaining

# Tutorial 3 - Libraries and Inheritance

Useful contracts can be deployed once and reused many times by others.

Create a contract called GetDateTime to use an [external datetime library](https://github.com/pipermerriam/ethereum-datetime) to get the day, month and year with a timestamp.

Create a child contract of GetDateTime called GetUpgradedDateTime to get hrs and mins as well.

## Business Rules

* GetDateTime should store the right day, month and year values with the unix timestamp of 1503282547.
* GetUpgradedDateTime should store the right day, month, yr, hr and mins value with the same unix timestamp 1503282547.

## Unit Test

* For GetDateTime contract, day should be 21, month should be 8, year should be 2017.
* For GetUpgradedDateTime, day should be 21, month should be 8, year should be 2017, hrs should be 2 and mins should be 29.

# Tutorial 4 - Crowd Funding Project

Create a simple crowd funding platform for users to create, manage and fund projects.

## Business Rules

* Create a contract called Project and it needs to have an owner address, project name, project description, deadline in timestamp and amount to be raised in ether. 
* Create another contract called ManageProject to allow anyone to create, read, update and delete projects. Only the creator of the project can update and delete the project.
* Anyone can fund any projects.
* When a project funding and dateline is reached, it will self destruct, giving all the project ether to the owner. 
* If the dateline is reached and funding not fulfilled, let individual funders get their funds back.

## Unit Tests

# Tutorial 5 - The frontend

Create a one-pager frontend for tutorial 4 (the crowd funding project).

Users are expected to have metamask installed.

## Business Rules

* All users should see all projects in the browser.
* All users can create new projects after filling in the compulsory fields.
* All users can fund any projects using any amount of ether, but not greater than the fund limit set by the project creator.
* Funded projects should be removed from the listings in the browser.

# References

* [Solidity Doc](https://solidity.readthedocs.io/en/develop/)
* [Truffle framework](http://truffleframework.com/docs/getting_started/contracts)
