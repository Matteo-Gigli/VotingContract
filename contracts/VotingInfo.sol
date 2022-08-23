//SPDX-License-Identifier: UNLICENSED

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Voting.sol";
import "./VotingToken.sol";

pragma solidity ^0.8.4;

contract VotingInfo is Ownable{

    Voting voting;
    VotingToken votingToken;


    mapping(address=>bool)private votedAlready;
    mapping(address=>bool)private withdrawHappen;

    modifier onlyVoting{
        msg.sender == address(voting);
        _;
    }

    modifier onlyVotingToken{
        msg.sender == address(votingToken);
        _;
    }

    constructor(){

    }


    function initVotingContract(address _votingAddress)public onlyOwner{
        voting = Voting(_votingAddress);
    }



    function setVoteHappen(address voter)public onlyVoting{
        votedAlready[voter] = true;
    }



    function getUserVotationStatus(address voter)public view returns(bool){
        return votedAlready[voter];
    }



    function setWithdrawedHappen(address voter)public onlyVotingToken{
        withdrawHappen[voter] = true;
    }



    function getWhitdrawStatus(address voter)public view returns(bool){
        return withdrawHappen[voter];
    }
}
