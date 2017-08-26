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

## Functional Tests

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

# References

* [Solidity Doc](https://solidity.readthedocs.io/en/develop/)
* [Truffle framework](http://truffleframework.com/docs/getting_started/contracts)
