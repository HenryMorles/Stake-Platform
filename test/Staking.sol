// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "../contracts/Staking.sol";
import "../contracts/FortY.sol";

contract StakingTest {
    FortY stakingToken;
    Staking stakingContract;

    function beforeEach() public {
        // Deploy token contract with an initial balance of 1000 tokens
        stakingToken = new FortY(1000);

        // Deploy the staking contract
        stakingContract = new Staking(address(stakingToken), 1);

        // Transfer 100 tokens to the staking contract address for rewards
        stakingToken.transfer(address(stakingContract), 100 * (10 ** stakingToken.decimals()));

        // Approve the transfer of tokens for staking
        stakingToken.approve(address(stakingContract), 100 * (10 ** stakingToken.decimals()));
    }

    // Test for staking tokens
    function testStakeTokens() public {
        stakingContract.stake(10 * (10 ** stakingToken.decimals()));
    
        (uint256 amount, ) = stakingContract.stakes(address(this));
    
        Assert.equal(amount, 10 * (10 ** stakingToken.decimals()), "Staked amount should be 10 tokens");
    }

    // Test for the emergencyUnstake function
    function testEmergencyUnstake() public {
        // Stake tokens
        stakingContract.stake(10 * (10 ** stakingToken.decimals()));

        stakingContract.emergencyUnstake();

        // Check balance after emergency unstake (without rewards)
        uint256 balance = stakingToken.balanceOf(address(this));
        Assert.equal(balance, 990 * (10 ** stakingToken.decimals()), "Balance after emergency unstaking should be 990 tokens");
    }

    // Test for setting the reward rate
    function testSetRewardRate() public {
        // Change reward rate to 2 tokens per second
        stakingContract.setRewardRate(2);

        // Check that the reward rate has been changed
        Assert.equal(stakingContract.rewardRate(), 2, "Reward rate should be set to 2 tokens per second");
    }
}