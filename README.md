# Tutorial 4 - Crowd Funding Project

Create a simple crowd funding contract for users to create, manage and fund projects.

## Business Rules

* Create a contract called Project and it needs to have an owner address, project name, project description, deadline in number of blocks from the date of creation and amount to be raised in ether. 
* Create another contract called ManageProject to allow anyone to create, read, update and delete projects. Only the creator of the project can update and delete the project.
* Anyone can fund any projects.
* When a project funding and dateline is reached (whichever comes firstpwd), it will self destruct, giving all the project ether to the project owner. 
* If the dateline is reached and funding not fulfilled, let individual funders can get their funds back if they wish.

## Functional Tests


# References

* [Solidity Doc](https://solidity.readthedocs.io/en/develop/)
* [Truffle framework](http://truffleframework.com/docs/getting_started/contracts)
