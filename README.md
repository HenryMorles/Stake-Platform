#FortY Token & Staking Contract
This project includes a token contract, FortY, and a staking contract, Staking. The FortY contract is an ERC20 token with an adjustable transaction fee, controlled by the owner. The Staking contract allows users to lock their FortY tokens to earn rewards over time. Users can stake tokens, accumulate rewards based on the duration of staking, and either unstake to claim rewards or use an emergency unstake option without rewards.

Table of Contents
Project Overview
Smart Contracts
FortY
Staking
Installation
Usage
Tests
License
Project Overview
The project consists of two main components:

FortY: An ERC20 token with an adjustable fee for transfers. The fee percentage is controlled by the owner, and it is capped at a maximum of 20%. The owner can also pause or unpause token transfers.

Staking Contract: A staking system that allows users to lock their FortY tokens and earn rewards over time. The staking contract provides two main functions:

Stake: Users can lock their tokens to start earning rewards.
Unstake: Users can unlock their staked tokens to claim the rewards based on the duration they staked.
Emergency Unstake: Users can unlock their tokens early without rewards.
Smart Contracts
FortY Token
The FortY contract is an ERC20 token with the following features:

Initial Supply: The initial supply is provided during the deployment of the contract.
Transfer Fee: A percentage fee is applied to each transfer, which is sent to the owner. The fee is set by the owner and can be adjusted, but cannot exceed 20%.
Pause/Unpause: The owner has the ability to pause and unpause all token transfers.
Staking Contract
The Staking contract allows users to lock their FortY tokens in return for staking rewards.

Stake Tokens: Users can lock their tokens in the contract to start earning rewards over time. The amount of rewards is based on the duration of the staking period and the reward rate.
Unstake Tokens: Users can unlock their tokens and claim the rewards after the staking duration has passed.
Emergency Unstake: Users can unlock their tokens early but will forfeit any accumulated rewards.
Set Reward Rate: The owner of the contract can set the reward rate, determining the amount of tokens rewarded per second.
Installation
Clone the Repository

bash
Копировать код
git clone https://github.com/your-repo-url.git
cd your-repo-name
Install Dependencies Make sure you have Node.js and npm installed.

bash
Копировать код
npm install
Compile Contracts To compile the contracts, use the Hardhat command:

bash
Копировать код
npx hardhat compile
Usage
Deploy Contracts You can deploy the contracts on a local Hardhat network or any Ethereum testnet/mainnet by running the following command:

bash
Копировать код
npx hardhat run scripts/deploy.js --network <network-name>
Interacting with Contracts Once deployed, you can interact with the FortY and Staking contracts via a JavaScript script, Hardhat console, or web interface using tools like Ethers.js or Web3.js.

Tests
Running Unit Tests
Unit tests are written using the Remix Testing Framework and cover core functionalities of both contracts, including staking, reward calculation, and emergency unstaking.

Run All Tests To run all the tests, use the Hardhat command:

bash
Копировать код
npx hardhat test
Test Contracts in Remix You can also test the contracts directly in the Remix IDE.

Test Coverage
The test coverage includes:

FortY Contract:
Correct initial supply and balance.
Correct application of transfer fees.
Ability to change transfer fee percentage by the owner.
Ability to pause and unpause transfers.
Staking Contract:
Staking and unstaking of tokens.
Calculation of staking rewards.
Emergency unstaking without rewards.
Ability to change reward rate by the owner.
License
This project is licensed under the MIT License.

Feel free to modify or expand the sections based on your project specifics!
