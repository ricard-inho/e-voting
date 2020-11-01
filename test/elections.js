var Elections = artifacts.require("./Elections.sol");

contract("Elections", function(accounts) {
	var electionInstance;

	it("Initializes with a chairPerson", function() {
		return Elections.deployed().then(function(instance) {
			electionInstance = instance;
			return instance.votersCount();
		}).then(function(count) {
			assert.equal(count, 1);
		});
	});
});