
# Overview 

Solution to Open Zeppelin DVDefi Challenge 1 

https://www.damnvulnerabledefi.xyz/challenges/1.html

My solution is entirely written in Solidity 0.8.0 and runs in Reminx, you just need to 

1. Copy Paste the following contracts in Remix 

2. Compile them 

3. Deploy them according to the given instructions 

4. Interact with them according to the given instructions 



# Contracts 

[unstoppable_lender.sol](unstoppable_lender.sol)

- the lender we have to stop 

[unstoppable_receiver.sol](unstoppable_receiver.sol)

- the receiver presenting the `executeFlashLoand()` function using the lender `flashLoand()` function which we have to stop 

- it presents 

  - the `depositTokens()` function to deposit tokens in the pool and it is the key to solve this challenge 

  - the `flashLoan()` allowing to execute a flash loan and it is the function we have to stop 

[simple_token.sol](simple_token.sol)

- just a simple ERC20 token to make this example work 

- it presents 

  - the `executeFlashLoan()` function running a flash loan and this is what we need to stop working 

  - the `receiveTokens()` function which is the Flash Loan Callback

[solution.sol](solution.sol)

- the contract solving the challenge 



# Deployment 

Everything can be done from a single EOA  

1. Deploy the `SimpleToken` contract, specifying a non zero `initialSupply` that will be minted for `msg.sender` when deployed 

2. Deploy the `UnstoppableLender` contract, passing the `SimpleToken` address 

3. Approve a certain amount of tokens for the `UnstoppableLender` SC

4. Deposit the tokens by calling `UnstoppableLender.depositTokens()` function 

5. Deploy the `ReceiverUnstoppable` passing the `UnstoppableLender` address 





# Test 

Running the `ReceiverUnstoppable.executeFlashLoan()` it should work and this is what we need to stop to solve this exercise 



# Solution 

The idea is simple, in `UnstoppableLender.flashLoan()` we see this check 

```solidity
        // Ensured by the protocol via the `depositTokens` function
        assert(poolBalance == balanceBefore);
```


and `balanceBefore` is defined as 

```solidity
        uint256 balanceBefore = damnValuableToken.balanceOf(address(this));
```

while `poolBalance` is a state variable  

```solidity
    uint256 public poolBalance;
```

updated in `depositTokens()` only 

```solidity
        poolBalance = poolBalance + (amount);
```

NOTE 

- I have removed all the OpenZeppelin SafeMath since I am using Solidity 0.8.0 



So clearly this is a redundant information and a misalignment would mean a logical fault that would stop the SC from working: this is what we are looking for 



So how can we make these 2 values different? 

What if we send tokens to this SC directly without calling the `depositTokens()` function? 

Obviously the result of the ERC20 `balanceOf()` will reflect this additional amount of token while the `depositTokens()` won't since it is not called: here is what we are looking for 

The `Solution` SC just requires to be have at least 1 token to send to the pool so it can create the misalignment stopping the lender contract 





