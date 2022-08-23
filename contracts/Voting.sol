//SPDX-License-Identifier: UNLICENSED


import "@openzeppelin/contracts/access/Ownable.sol";
import "./VotingToken.sol";

pragma solidity ^0.8.4;

contract Voting is Ownable{

    VotingToken private votingToken;
    VotingInfo private votingInfo;

    uint endingVotationTime;

    enum Presidents{Obama, Trump, Biden}

    event FinalResult(
        string firstCandidate,
        uint finalVoteFirst,
        string secondCandidate,
        uint finalVoteSecond,
        string thirdCandidate,
        uint finalVoteThird
        );


    mapping(Presidents=>uint) private Counter;

    constructor(uint _endingVotationTime){
        endingVotationTime = _endingVotationTime;
    }



    function initVotingTokenContract(address _votingTokenAddress)public onlyOwner{
        votingToken = VotingToken(_votingTokenAddress);
        votingToken.increaseAllowance(address(this), votingToken.balanceOf(votingToken.owner()));
    }



    function initVotingInfoContract(address _votingInfoContract)public onlyOwner{
        votingInfo = VotingInfo(_votingInfoContract);
    }



    function withdraw()external{
        require(votingInfo.getWhitdrawStatus(msg.sender)==false, "Already Withdrawed!");
        require(msg.sender != votingToken.owner(), "Admin: can't withdraw!");
        require(block.timestamp < endingVotationTime, "Votation Ending!");
        votingInfo.setWithdrawedHappen(msg.sender);
        votingToken.transferFrom(votingToken.owner(), msg.sender, 1);
    }



    function votingObama()external{
        require(votingToken.balanceOf(msg.sender) > 0, "Don't have tokens to vote!");
        require(msg.sender != owner(), "Admin cannot vote!");
        require(msg.sender != votingToken.owner(), "Admin cannot vote!");
        require(block.timestamp < endingVotationTime, "Votation Ending!");
        votingInfo.setVoteHappen(msg.sender);
        votingToken.burn(msg.sender, 1);
        Counter[Presidents.Obama] += 1;
    }



    function votingTrump()external{
        require(votingToken.balanceOf(msg.sender) > 0, "Don't have tokens to vote!");
        require(msg.sender != owner(), "Admin cannot vote!");
        require(msg.sender != votingToken.owner(), "Admin cannot vote!");
        require(block.timestamp < endingVotationTime, "Votation Ending!");
        votingInfo.setVoteHappen(msg.sender);
        votingToken.burn(msg.sender, 1);
        Counter[Presidents.Trump] += 1;
    }



    function votingBiden()external{
        require(votingToken.balanceOf(msg.sender) > 0, "Don't have tokens to vote!");
        require(msg.sender != owner(), "Admin cannot vote!");
        require(msg.sender != votingToken.owner(), "Admin cannot vote!");
        require(block.timestamp < endingVotationTime, "Votation Ending!");
        votingInfo.setVoteHappen(msg.sender);
        votingToken.burn(msg.sender, 1);
        Counter[Presidents.Biden] += 1;
    }



    function presidentObamaStats()public view returns(uint){
        return Counter[Presidents.Obama];
    }



    function presidentTrumpStats()public view returns(uint){
        return Counter[Presidents.Trump];
    }



    function presidentBidenStats()public view returns(uint){
        return Counter[Presidents.Biden];
    }



    function getVotingResult()public onlyOwner{
        require(block.timestamp >= endingVotationTime, "Final Count is not available yet!");
        emit FinalResult(
            "Obama's Final Count ",
            Counter[Presidents.Obama],
            "Trump's Final Count ",
            Counter[Presidents.Trump],
            "Biden's Final Count ",
            Counter[Presidents.Biden]
        );
    }



    function getVotingTokenContract()public view returns(address){
        return address(votingToken);
    }



    function getVotingInfoContract()public view returns(address){
        return address(votingInfo);
    }
}
