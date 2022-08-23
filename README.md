<h2>📃 Project</h2>

<h4>The idea is to have a simple Voting system, moved from a token(ERC20) used for the votation.</h4>
<h4>We have 3 different contracts</h4>
<br>

<h2>🔎 VotingToken.sol</h2>
<h4>This is the contract used for the creation of our new Coin (ERC20 Standard)/h4>
<h4>Now we can jump in the contract and see all the functions.</h4>
<h4>First of all the modifier onlyVoting is created to give the allowed to the Voting.sol contract, to call a specific function.</h4>
<h4>We have 1 function: initVotingContract and will be used for initialize the Voting contract(Voting.sol).</h4>
<h4>So just be sure to set the right address!</h4>
<h4>Then we have the burn function, that allowed the Voting address to burn 1 token after every votation.</h4>
<br> 

<h2>🔎 Voting.sol</h2>
<h4>This is the Voting Contract.</h4>
<h4>As usual we have 2 functions to initialize our 2 others contract.</h4>
<h4>Then we have the withdraw function to receive token to make votation.</h4>
<h4>We have to chose 1 on 3 Presidents to make our preference!</h4>
<h4>So now if we already withdrawed our token(necessary to make a preference), we can choose to who give our vote</h4>
<h4>Once we got it, we cannot change/withdraw again and give another vote to someone else.</h4>
<h4>At the end we have the last function, getVotingResult() that allowed only the owner to check the result of votation!/h4>
<br> 
  

<h2>🔎 VotingInfo.sol</h2>
<h4>This is the Voting Info Contract.</h4>
<h4>As usual we have a function to initialize Voting contract and some usefull functions to get and set info</h4>


<h2>🔨 Built with</h2>
<h4>Solidity, Hardhat</h4>
