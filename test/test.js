const { expect } = require("chai");
const { expectRevert} = require('@openzeppelin/test-helpers');


describe("Setting some test for the functionality of the contracts", function() {

    let Voting, voting, VotingToken, votingToken, VotingInfo, votingInfo,
        owner, account1, account2, account3, account4, account5;


    before(async () => {

        [owner, account1, account2, account3, account4, account5] = await ethers.getSigners();

        Voting = await ethers.getContractFactory("Voting");
        voting = await Voting.deploy(1661273562);

        VotingToken = await ethers.getContractFactory("VotingToken");
        votingToken = await VotingToken.deploy("Voting Token", "VT", 1000);

        VotingInfo = await ethers.getContractFactory("VotingInfo");
        votingInfo = await VotingInfo.deploy();


        await voting.deployed();
        await votingToken.deployed();
        await votingInfo.deployed();


        await voting.initVotingTokenContract(votingToken.address);
        await voting.initVotingInfoContract(votingInfo.address);
        await votingInfo.initVotingContract(voting.address);
        await votingToken.initVotingContract(voting.address);
    })


    it("Should revert withdraw if caller is the owner", async()=>{
        await expectRevert(voting.withdraw(), "Admin: can't withdraw!");
        let ownerBalanceOf = await votingToken.balanceOf(owner.address);
        expect(ownerBalanceOf).to.be.equal(1000);
    })



    it("should be able to withdraw 1 token", async()=>{
        await voting.connect(account1).withdraw();
        let account1BalanceOf = await votingToken.balanceOf(account1.address);
        expect(account1BalanceOf).to.be.equal(1);
    })



    it("should be able to withdraw 1 token", async()=>{
        await voting.connect(account2).withdraw();
        let account2BalanceOf = await votingToken.balanceOf(account2.address);
        expect(account2BalanceOf).to.be.equal(1);
    })



    it("should be able to withdraw 1 token", async()=>{
        await voting.connect(account3).withdraw();
        let account3BalanceOf = await votingToken.balanceOf(account3.address);
        expect(account3BalanceOf).to.be.equal(1);
    })



    it("should be able to withdraw 1 token", async()=>{
        await voting.connect(account4).withdraw();
        let account4BalanceOf = await votingToken.balanceOf(account4.address);
        expect(account4BalanceOf).to.be.equal(1);
    })



    it("should revert the votation if caller is the owner", async()=>{
        await expectRevert(voting.votingObama(), "Admin cannot vote!");
        let obamaVoting = await voting.presidentObamaStats();
        expect(obamaVoting).to.be.equal(0);
    })


    it("should revert the votation if caller is the owner", async()=>{
        await expectRevert(voting.votingBiden(), "Admin cannot vote!");
        let bidenVoting = await voting.presidentObamaStats();
        expect(bidenVoting).to.be.equal(0);
    })



    it("should revert the votation if caller is the owner", async()=>{
        await expectRevert(voting.votingTrump(), "Admin cannot vote!");
        let trumpVoting = await voting.presidentObamaStats();
        expect(trumpVoting).to.be.equal(0);
    })



    it("should revert the votation if we don't have token to vote", async()=>{
        await expectRevert(voting.connect(account5).votingTrump(), "Don't have tokens to vote!");
        let trumpVoting = await voting.presidentObamaStats();
        expect(trumpVoting).to.be.equal(0);
    })



    it("should be able to make votation", async()=>{
        await voting.connect(account1).votingObama();
        let obamaVoting = await voting.presidentObamaStats();
        expect(obamaVoting).to.be.equal(1);
    })

    it("should be able to make votation", async()=>{
        await voting.connect(account2).votingObama();
        let obamaVoting = await voting.presidentObamaStats();
        expect(obamaVoting).to.be.equal(2);
    })


    it("should be able to make votation", async()=>{
        await voting.connect(account3).votingTrump();
        let trumpVoting = await voting.presidentTrumpStats();
        expect(trumpVoting).to.be.equal(1);
    })


    it("should be able to make votation", async()=>{
        await voting.connect(account4).votingBiden();
        let bidenVoting = await voting.presidentBidenStats();
        expect(bidenVoting).to.be.equal(1);

        let votationUserStatus = await votingInfo.getUserVotationStatus(account4.address);
        expect(votationUserStatus).to.be.equal(true);
    })


    it("should revert the withdraw if we already made it", async()=>{
        await expectRevert(voting.connect(account4).withdraw(), "Already Withdrawed!");
    })


    it("should revert the get voting result function, if time is not passed", async()=>{
        await expectRevert(voting.getVotingResult(), "Final Count is not available yet!");
    })



    it('should mint 1 day', async () => {
        let actualBlock = await ethers.provider.getBlockNumber();
        let blockToMint = await (actualBlock + 7500);
        for (let i = 0; i < blockToMint; i++) {
            await ethers.provider.send('evm_mine', []);
        }
    });


    it("should be able to get the final result", async()=>{
        await voting.getVotingResult();
        let obamaStast = await voting.presidentObamaStats();
        let trumpStats = await voting.presidentTrumpStats();
        let bidenStats = await voting.presidentBidenStats();
        expect(obamaStast).to.be.equal(2);
        expect(trumpStats).to.be.equal(1);
        expect(bidenStats).to.be.equal(1);
    })

})