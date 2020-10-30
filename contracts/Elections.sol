pragma solidity 0.5.1;

contract Elections {

	struct Voter {
		uint rightToVote;
		bool voted; //If true, Voter already voted in election
	}

	struct Election {
		bytes32 name;
		uint voteCount;
		uint256 openingTime;
		uint256 closingTime;
		Proposal[] proposals;
	}

	struct Proposal {
		bytes32 name;
		uint voteCount;
	}

	address chairPerson;
	mapping(address => Voter) public voters;
	Election[] public elections;

	modifier onlyChairPerson() {
		require(msg.sender == chairPerson);
		_;
	}

	constructor() public {
		chairPerson = msg.sender;
		voters[chairPerson].rightToVote = 1;
	}

	/**
	* @dev vote for a proposal
	* @param _election index of election to vote
	* @param _proposal index of proposal to vote
	*/
	function vote(uint _election, uint _proposal) public {
		Voter storage sender = voters[msg.sender];
		require(!sender.voted, "You already voted.");

		sender.voted = true;
		elections[_election].proposals[_proposal].voteCount += 1;
	}
}