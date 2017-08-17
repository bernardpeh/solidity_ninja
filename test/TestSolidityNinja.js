var sn = artifacts.require("./SolidityNinja.sol");

contract('TestSolidityNinja', function(accounts) {

	function getName() {
    return sn.deployed().then(function(ins) {
      return ins.getName.call();
    }).then(function(val) {
      return val;
    });
	}

	function getOwnerAddress() {
    return sn.deployed().then(function(ins) {
      return ins.getOwner.call();
    }).then(function(val) {
      return val;
    });
	}

  it("should get the right initial owner's name", function() {
  	return getName().then(function(val) {
      assert.equal(val, 'Satoshi Nakamoto', "The owner name should be 'Satoshi Nakamoto'");
    });
  });

  it("should get the right inital owner's address", function() {
		return getOwnerAddress(function(val) {
      assert.equal(val, accounts[0], "The owner address should be acct0")
		})
  });

	it("should set the name correctly", function() {
		return sn.deployed().then(function(ins) {
			return ins.setName("ali baba");
		}).then(function() {
      return getName().then(function(val) {
        assert.equal(val, 'ali baba',  "The new owner name should be 'ali baba'");
      });
		});
	});

	it("should set acct1 as new owner", function() {
    return sn.deployed().then(function(ins) {
      return ins.setOwner(accounts[1]);
    }).then(function() {
      return getOwnerAddress(function(val) {
        assert.equal(val, accounts[1], "The NEW owner address should now be acct1")
      })
    });
	});

  it("should not set acct1 as new owner if owner is already acct1", function() {
    return sn.deployed().then(function(ins) {
      return ins.setOwner(accounts[1], {from: accounts[1]});
    }).catch(function(err) {
      assert.isAbove(err.message.indexOf('invalid opcode'), 0, "acct1 cannot set itself as owner anymore")
    });
  });

  it("should not be able to set acct2 as new owner if owner is now acct0", function() {
    return sn.deployed().then(function(ins) {
      return ins.setOwner(accounts[2], {from: accounts[0]});
    }).catch(function(err) {
      assert.isAbove(err.message.indexOf('invalid opcode'), 0, "acct0 cannot set acct2 as new owner since it is not the owner")
    });
  });
});