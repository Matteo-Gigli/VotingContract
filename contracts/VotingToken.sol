//SPDX-License-Identifier: UNLICENSED

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Voting.sol";
import "./VotingInfo.sol";

pragma solidity ^0.8.4;

contract VotingToken is Ownable, ERC20{

    Voting private voting;

    uint private _totalSupply;

    mapping(address=>uint)private _balances;


    modifier onlyVoting(){
        msg.sender == address(voting);
        _;
    }



    constructor(string memory name, string memory symbol, uint totalsupply)ERC20(name, symbol){
        _totalSupply = totalsupply;
        _mint(msg.sender, _totalSupply);
        _balances[msg.sender] += _totalSupply;
    }



    function initVotingContract(address _votingAddress)public onlyOwner{
        voting = Voting(_votingAddress);
    }



    function increaseAllowance(address spender, uint256 addedValue) public virtual override returns (bool) {
        address owner = owner();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }



    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override{
        _balances[from] -= amount;
        _balances[to] += amount;
        super._transfer(from,to,amount);
    }



    function balanceOf(address account) public view virtual override returns (uint256){
        return _balances[account];
    }



    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }



    function burn(address account, uint amount)public onlyVoting{
        _balances[account] -= amount;
        _totalSupply -= amount;
        super._burn(account, amount);
    }



}
