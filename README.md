# About

Solidity Ninja is a short course for learning Solidity.

This course should be a good learning experience for developers who are new to solidity.

## Exercises

* Using Testrpc, Send x amount of ether from account0 to account1 such that account0 will have 99 ether exactly.

* Base on ethstats.net, calculate max transactions per second of the ethereum network. Check your answer with https://etherchain.org/ 

## Prerequisites

1. Install [truffle](https://github.com/trufflesuite/truffle). 

2. Install [testrpc](https://github.com/ethereumjs/testrpc)

3. Install [ether explorer](https://github.com/etherparty/explorer)

3. git clone git@github.com:bernardpeh/solidity_ninja.git or fork

## Quick start

1. In a new terminal, start testrpc
```
testrpc -m "enlist illness roast pair check danger drill noble dove repeat great margin"
```

You should get these newly generated accounts if your mnemonic seed above is correct.

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

2. In a separate terminal, start tutorial 1 and follow the readme instructions from there

```
-> git checkout tut_1 
```
# Tips

* Many people like the old remix browser better:  https://yann300.github.io
* solidity flattener is useful to combine truffle files into one to load into remix: https://github.com/BlockCatIO/solidity-flattener
* Parity client seems to be more stable for quick syncing ropsten network


# References

* [Solidity Doc](https://solidity.readthedocs.io/en/develop/)
* [Truffle framework](http://truffleframework.com/docs/getting_started/contracts)
* [Introduction to Accounts, Transactions and Gas](https://hudsonjameson.com/2017-06-27-accounts-transactions-gas-ethereum/)
* [Inside a transaction](https://medium.com/@codetractio/inside-an-ethereum-transaction-fa94ffca912f)
