pragma solidity ^0.4.4;

contract EventSales {

	uint public tickets = 20;
	uint public constant price = 1 ether;
	mapping (address => uint) public buyers;
	address public owner;
	uint initBlock;
	// assuming 20s per block, its about 4320 blocks mined in a day.
	// note it is also possible to use block.timestamp in utc
	uint constant dueBlock = 30;

	// log ticket params before transaction
	event logBuyingTicket(address buyer,uint no_of_tickets, uint total_price);

	// log ticket params after transaction.
	event logBoughtTicket(address buyer,uint no_of_tickets, uint total_price);

	// constructor
	function EventSales() {
		owner = msg.sender;
		initBlock = block.number;
	}

	// where n is the number of tickets
	function buyTickets(uint n) payable {

		// Make sure event is not expired before we run this
		require(isEventExpired() == false);

		logBuyingTicket(msg.sender, n, msg.value);

		// user cannot send more or less than 1 eth for each ticket
		require(msg.value == n*price);

		// buyer needs to buy at least 1 ticket and there needs to be enough tickets to be bought
		require(tickets >= n && n > 0);

		// increase buyer number of tickets
		buyers[msg.sender] += n;

		// reduce number of tickets
		tickets -= n;

		// if tickets is all sold out, we cash out everything to the owner
		if (tickets == 0) {
			kill();
		}
	}

	// allows user to cancel their ticket and refund
	// where n is the number of tickets
	function refund(uint n) {
		// user cannot refund more tickets than they have
		require(buyers[msg.sender] >= n);
		// reduce buyer tickets
		buyers[msg.sender] -= n;
		// increase number of tickets inside the pool
		tickets++;
		// now we can transfer the money
		msg.sender.transfer(n*price);
	}

	// check if event is still on
	function isEventExpired() returns (bool){
		if (block.number > initBlock + dueBlock) {
			return true;
		}
		return false;
	}

	// returns contract balace atm
	function getContractBalance() returns(uint) {
		return this.balance;
	}

	// owner can terminate contract after it expires
	function ownerTerminate() {
		require(isEventExpired() == true);
		require(msg.sender == owner);
		kill();
	}
	// kill contract internally
	function kill() internal {
		selfdestruct(owner);
	}

	// what if people send money to this contract? Automatically buys ticket or not?
	function () payable {
		// buyTickets(1);
	}
}