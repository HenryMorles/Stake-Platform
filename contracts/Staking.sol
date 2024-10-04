// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Staking is Ownable {
    IERC20 public stakingToken;
    uint256 public rewardRate; // Reward rate per second
    uint256 public stakingDuration = 1 minutes; // Example staking period

    struct Stake {
        uint256 amount;
        uint256 timestamp;
    }

    mapping(address => Stake) public stakes;

    constructor(address _stakingToken, uint256 _rewardRate) Ownable(msg.sender) {
        stakingToken = IERC20(_stakingToken);
        rewardRate = _rewardRate;
    }

    // Function for users to stake tokens
    function stake(uint256 amount) external {
    require(amount > 0, "Cannot stake 0 tokens");

    // Calculate any pending rewards and add to stake amount
    uint256 pendingReward = calculateReward(msg.sender);

    // Transfer tokens to the staking contract
    stakingToken.transferFrom(msg.sender, address(this), amount);

    // Update the user's staking data
    stakes[msg.sender].amount += amount + pendingReward; // Include rewards earned so far
    stakes[msg.sender].timestamp = block.timestamp; // Update timestamp
    }

    // Function to calculate rewards
    function calculateReward(address user) public view returns (uint256) {
        Stake memory userStake = stakes[user];
        uint256 stakedDuration = block.timestamp - userStake.timestamp;

        // Calculate reward based on rewardRate and staked duration
        return (userStake.amount * stakedDuration * rewardRate) / 1e18;
    }

    // Function to unstake tokens and claim rewards
    function unstake() external {
        Stake memory userStake = stakes[msg.sender];
        require(userStake.amount > 0, "No tokens staked");
        require(block.timestamp >= userStake.timestamp + stakingDuration, "Tokens are still locked");

        // Calculate rewards
        uint256 reward = calculateReward(msg.sender);

        // Reset user's stake
        uint256 amountToTransfer = userStake.amount + reward;
        stakes[msg.sender].amount = 0;

        // Transfer the staked tokens + rewards back to the user
        stakingToken.transfer(msg.sender, amountToTransfer);
    }

    // Emergency unstake function without rewards
    function emergencyUnstake() external {
        Stake memory userStake = stakes[msg.sender];
        require(userStake.amount > 0, "No tokens staked");

        uint256 amountToTransfer = userStake.amount;

        // Reset user's stake
        stakes[msg.sender].amount = 0;

        // Transfer only the staked tokens back to the user (without rewards)
        stakingToken.transfer(msg.sender, amountToTransfer);
    }

    // Function to update the reward rate (only owner)
    function setRewardRate(uint256 newRate) external onlyOwner {
        rewardRate = newRate;
    }
}