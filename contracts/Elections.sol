pragma solidity ^0.5.1;

contract Elections {

	struct Voter {
		uint rightToVote;
		bool voted; //If true, Voter already voted in election
	}

	struct Election {
		uint id;
		string name;
		uint voteCount;
		uint256 openingTime;
		uint256 closingTime;
		mapping(uint => Proposal) proposals;
		uint proposalsCount;
	}

	struct Proposal {
		uint id;
		string name;
		uint voteCount;
	}


	address public chairPerson;

	mapping(address => Voter) public voters;
	uint public votersCount;

	mapping(uint => Election) public elections;
	uint public electionsCount;


	modifier onlyChairPerson() {
		require(msg.sender == chairPerson);
		_;
	}

	constructor() public {
		chairPerson = msg.sender;
		voters[chairPerson].rightToVote = 1;
		voters[chairPerson].voted = false;
		votersCount++;
	}



	/**
	* @dev add a proposal
	* @param _election index of election to add a proposal
	* @param _name name of the proposal
	*/
	function addProposal (uint _election, string memory _name) private {
		uint propCount = elections[_election].proposalsCount;
		elections[_election].proposals[propCount] = Proposal(propCount, _name, 0);
		elections[_election].proposalsCount ++;
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


	/**
	* @dev Set the opening time of the election
	* @param _election index of election to set the time
	* @param _openingTime time to open the election
	*/
	function setOpeningTime(uint _election, uint256 _openingTime) private onlyChairPerson {
		elections[_election].openingTime = _openingTime;
	}

	/**
	* @dev Set the closing time of the election
	* @param _election index of election to set the time
	* @param _closingTime time to close the election
	*/
	function setClosingTime(uint _election, uint256 _closingTime) private onlyChairPerson {
		elections[_election].closingTime = _closingTime;
	}
}