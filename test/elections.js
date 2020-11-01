var Elections = artifacts.require("./Elections.sol");

contract("Elections", function(accounts) {
	it("Initializes with a chairPerson", function() {
		return Elections.deployed().then(function(instance) {
			return instance.votersCount();
		}).then(function(count) {
			assert.equal(count, 1);
		});
	});
});