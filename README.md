# FortY Token & Staking Contract

This project includes a token contract, **FortY**, and a staking contract, **Staking**. The **FortY** contract is an ERC20 token with an adjustable transaction fee, controlled by the owner. The **Staking** contract allows users to lock their **FortY** tokens to earn rewards over time. Users can stake tokens, accumulate rewards based on the duration of staking, and either unstake to claim rewards or use an emergency unstake option without rewards.

## Table of Contents

- [Project Overview](#project-overview)
- [Smart Contracts](#smart-contracts)
- [FortY Token](#forty-token)
- [Staking Contract](#staking-contract)
- [Installation](#installation)
- [Usage](#usage)
- [Tests](#tests)
- [License](#license)

## Project Overview

The project consists of two main components:

1. **FortY**: An ERC20 token with an adjustable fee for transfers. The fee percentage is controlled by the owner, and it is capped at a maximum of 20%. The owner can also pause or unpause token transfers.

2. **Staking Contract**: A staking system that allows users to lock their **FortY** tokens and earn rewards over time. The staking contract provides main functions for staking and unstaking, along with reward calculation based on the staking duration.

## Smart Contracts

### FortY Token

The **FortY** contract is an ERC20 token with the following features:

- **Initial Supply**: The initial supply is provided during the deployment of the contract.
- **Transfer Fee**: A percentage fee is applied to each transfer, which is sent to the owner. The fee is set by the owner and can be adjusted, but cannot exceed 20%.
- **Pause/Unpause**: The owner has the ability to pause and unpause all token transfers.

### Staking Contract

The **Staking** contract allows users to lock their **FortY** tokens in return for staking rewards.

- **Stake Tokens**: Users can lock their tokens in the contract to start earning rewards over time. The amount of rewards is based on the duration of the staking period and the reward rate.
- **Unstake Tokens**: Users can unlock their tokens and claim the rewards after the staking duration has passed.
- **Emergency Unstake**: Users can unlock their tokens early but will forfeit any accumulated rewards.
- **Set Reward Rate**: The owner of the contract can set the reward rate, determining the amount of tokens rewarded per second.

## Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/HenryMorles/Stake_Platform.git
   cd your-repo-name
   ```

2. **Install Dependencies**  
   Make sure you have [Node.js](https://nodejs.org/) and [npm](https://www.npmjs.com/) installed.
   ```bash
   npm install
   ```

3. **Compile Contracts**  
   To compile the contracts, use the Hardhat command:
   ```bash
   npx hardhat compile
   ```

## Usage

1. **Deploy Contracts**  
   You can deploy the contracts on a local Hardhat network or any Ethereum testnet/mainnet by running the following command:
   ```bash
   npx hardhat run scripts/deploy.js --network <network-name>
   ```

2. **Interacting with Contracts**  
   Once deployed, you can interact with the **FortY** and **Staking** contracts via a JavaScript script, the Hardhat console, or a web interface using tools like [Ethers.js](https://docs.ethers.io/v5/) or [Web3.js](https://web3js.readthedocs.io/).

## Tests

### Running Unit Tests

Unit tests are provided for both the **FortY** and **Staking** contracts. The tests cover core functionalities including staking, reward calculation, emergency unstaking, and contract ownership features.

**Testing in Remix**  
   You can test the contracts using the [Remix IDE](https://remix.ethereum.org/). Simply upload the contract files and test files, and run the tests directly from the IDE.

### Test Coverage

The test suite includes the following coverage:

- **FortY Contract**:
  - Ensuring correct initial token supply.
  - Testing transfer functionalities with the correct application of the transaction fee.
  - Validating only the owner can change the transfer fee percentage.
  - Testing the ability to pause and unpause transfers.
  
- **Staking Contract**:
  - Verifying token staking and balance updates.
  - Correct calculation of staking rewards over time.
  - Handling of emergency unstaking without rewards.
  - Verifying only the owner can modify the reward rate.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
