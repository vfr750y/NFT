# VeeFour and Mood NFT Project

This project contains two Solidity smart contracts for creating and managing Non-Fungible Tokens (NFTs) on the Ethereum blockchain: `BasicNFT` and `MoodNft`. It includes deployment scripts and tests using the Foundry framework. Below is a comprehensive guide to the project structure, functionality, setup, and usage.

## Table of Contents
- [Project Overview](#project-overview)
- [Contracts](#contracts)
  - [BasicNFT](#basicnft)
  - [MoodNft](#moodnft)
- [Scripts](#scripts)
  - [DeployBasicNft](#deploybasicnft)
  - [Interactions](#interactions)
- [Tests](#tests)
  - [BasicNftTest](#basicnfttest)
  - [MoodNftTest](#moodnfttest)
- [Dependencies](#dependencies)
- [Setup and Installation](#setup-and-installation)
- [Usage](#usage)
  - [Deploying Contracts](#deploying-contracts)
  - [Minting NFTs](#minting-nfts)
  - [Running Tests](#running-tests)
- [File Structure](#file-structure)
- [License](#license)

## Project Overview
This project implements two ERC721-compliant NFT contracts:
- **BasicNFT**: A simple NFT contract that allows minting tokens with a specified token URI.
- **MoodNft**: An NFT contract that allows users to mint tokens with a mood (HAPPY or SAD), represented by different SVG images embedded in the token URI as base64-encoded JSON metadata.

The project uses Foundry for development, testing, and deployment. It includes scripts to deploy the contracts and interact with them, as well as unit tests to verify functionality.

## Contracts

### BasicNFT
- **File**: `src/BasicNFT.sol`
- **Description**: An ERC721 contract for minting NFTs with custom token URIs stored on-chain.
- **Key Features**:
  - Inherits from OpenZeppelin's `ERC721` contract.
  - Uses a token counter to assign unique token IDs.
  - Stores token URIs in a mapping (`s_tokenIdToUri`).
  - Allows minting NFTs with a provided `tokenUri` via the `mintNft` function.
  - Overrides the `tokenURI` function to return the stored URI for a given token ID.
- **Constructor**:
  - Initializes the ERC721 contract with the name "VeeFour" and symbol "VFR".
  - Sets the initial `s_tokenCounter` to 0.
- **Functions**:
  - `mintNft(string memory tokenUri)`: Mints a new NFT to the caller and associates it with the provided `tokenUri`.
  - `tokenURI(uint256 tokenId)`: Returns the token URI for a given `tokenId`.

### MoodNft
- **File**: `src/MoodNft.sol`
- **Description**: An ERC721 contract that mints NFTs with a mood state (HAPPY or SAD), represented by SVG images embedded in base64-encoded JSON metadata.
- **Key Features**:
  - Inherits from OpenZeppelin's `ERC721` and uses `Base64` for encoding metadata.
  - Tracks the mood of each token (HAPPY or SAD) in a mapping (`s_tokenIdToMood`).
  - Stores two SVG image URIs (`s_sadSvgImageUri` and `s_happySvgImageUri`) provided during deployment.
  - Generates dynamic token URIs with JSON metadata, including the NFT's name, description, attributes, and the appropriate SVG image based on the token's mood.
- **Constructor**:
  - Initializes the ERC721 contract with the name "Mood Nft" and symbol "MN".
  - Sets the `s_sadSvgImageUri` and `s_happySvgImageUri` based on constructor parameters.
  - Initializes `s_tokenCounter` to 0.
- **Functions**:
  - `mintNft()`: Mints a new NFT to the caller with a default mood of HAPPY.
  - `_baseURI()`: Returns the base URI for token metadata (`data:application/json;base64,`).
  - `tokenURI(uint256 tokenId)`: Generates and returns a base64-encoded JSON metadata URI containing the NFT's name, description, attributes, and the appropriate SVG image URI based on the token's mood.

## Scripts

### DeployBasicNft
- **File**: `script/DeployBasicNft.s.sol`
- **Description**: A Foundry script to deploy the `BasicNFT` contract.
- **Function**:
  - `run()`: Deploys a new instance of `BasicNFT` using `vm.startBroadcast()` and `vm.stopBroadcast()`. Returns the deployed contract instance.
- **Usage**: Run this script to deploy the `BasicNFT` contract to the blockchain.

### Interactions
- **File**: `script/Interactions.s.sol`
- **Description**: A Foundry script to mint an NFT on an existing `BasicNFT` contract.
- **Key Features**:
  - Uses the `DevOpsTools` library to retrieve the most recently deployed `BasicNFT` contract address for the current chain.
  - Defines a constant `VEEFOURHRC` with an IPFS URI for the NFT metadata.
  - Includes a commented-out alternative URI and a hardcoded contract address option (not used by default).
- **Functions**:
  - `run()`: Retrieves the most recent `BasicNFT` deployment address and calls `mintNftOnContract` with it.
  - `mintNftOnContract(address contractAddress)`: Mints an NFT on the specified `BasicNFT` contract using the `VEEFOURHRC` URI.
- **Usage**: Run this script to mint an NFT on a deployed `BasicNFT` contract.

## Tests

### BasicNftTest
- **File**: `test/BasicNftTest.t.sol`
- **Description**: A Foundry test suite for the `BasicNFT` contract.
- **Setup**:
  - Deploys a new `BasicNFT` contract using the `DeployBasicNft` script.
  - Defines a test user address (`USER`) and the `VEEFOURHRC` URI (same as in `Interactions.s.sol`).
- **Tests**:
  - `testNameIsCorrect`: Verifies that the contract's name is "VeeFour" by comparing the keccak256 hash of the expected and actual names.
  - `testCanMintAndHaveABalance`: Tests minting an NFT as the `USER`, verifying that the user's balance is 1 and the token URI for token ID 0 matches `VEEFOURHRC`.
- **Usage**: Run these tests to verify the functionality of the `BasicNFT` contract.

### MoodNftTest
- **File**: `test/MoodNftTest.t.sol`
- **Description**: A Foundry test suite for the `MoodNft` contract.
- **Setup**:
  - Deploys a new `MoodNft` contract with predefined HAPPY and SAD SVG URIs.
  - Defines a test user address (`USER`).
- **Tests**:
  - `testViewTokenURI`: Mints an NFT as the `USER` and logs the token URI for token ID 0 to the console for inspection.
- **Usage**: Run this test to verify the `MoodNft` contract's token URI generation. Note that the test currently logs the URI for manual verification; additional assertions could be added for automated checks.

## Dependencies
- **Solidity**: `^0.8.19`
- **OpenZeppelin Contracts**:
  - `@openzeppelin/contracts/token/ERC721/ERC721.sol`
  - `@openzeppelin/contracts/utils/Base64.sol`
- **Foundry**:
  - `forge-std/Script.sol`
  - `forge-std/Test.sol`
  - `forge-std/console.sol`
  - `foundry-devops/src/DevOpsTools.sol`
- **External Tools**:
  - Foundry (for compiling, testing, and deploying contracts)
  - An Ethereum-compatible blockchain (e.g., local Anvil, Sepolia testnet)

To install dependencies, ensure you have Foundry installed and run:
```bash
forge install OpenZeppelin/openzeppelin-contracts
forge install foundry-rs/forge-std
forge install Cyfrin/foundry-devops
```

## Setup and Installation
1. **Install Foundry**:
   - Follow the [Foundry installation guide](https://book.getfoundry.sh/getting-started/installation).
   - Ensure you have `forge` and `cast` installed.
2. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```
3. **Install Dependencies**:
   ```bash
   forge install
   ```
4. **Compile Contracts**:
   ```bash
   forge build
   ```
5. **Set Up Environment**:
   - Create a `.env` file for sensitive data (e.g., private keys, RPC URLs) if deploying to a testnet or mainnet.
   - Example `.env`:
     ```env
     PRIVATE_KEY=your_private_key
     RPC_URL=your_rpc_url
     ```

## Usage

### Deploying Contracts
To deploy the `BasicNFT` contract:
```bash
forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
```

To deploy the `MoodNft` contract, you need to create a deployment script (not provided in the project). Example script (`DeployMoodNft.s.sol`):
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract DeployMoodNft is Script {
    string public constant HAPPY_SVG_URI = "data:image/svg+xml;base64,..."; // Use the same URI as in MoodNftTest
    string public constant SAD_SVG_URI = "data:image/svg+xml;base64,..."; // Use the same URI as in MoodNftTest

    function run() external returns (MoodNft) {
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(SAD_SVG_URI, HAPPY_SVG_URI);
        vm.stopBroadcast();
        return moodNft;
    }
}
```
Then deploy:
```bash
forge script script/DeployMoodNft.s.sol:DeployMoodNft --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
```

### Minting NFTs
To mint an NFT on a deployed `BasicNFT` contract:
```bash
forge script script/Interactions.s.sol:MintBasicNft --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
```

To mint an NFT on a deployed `MoodNft` contract, create a script similar to `Interactions.s.sol`:
```solidity
// SPDX-License-License: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNft(contractAddress).mintNft();
        vm.stopBroadcast();
    }
}
```
Then run:
```bash
forge script script/MintMoodNft.s.sol:MintMoodNft --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
```

### Running Tests
To run all tests:
```bash
forge test
```

To run specific tests with verbose output:
```bash
forge test -vv
```

To run tests for a specific contract:
```bash
forge test --match-contract BasicNftTest
forge test --match-contract MoodNftTest
```

## File Structure
```
├── script/
│   ├── DeployBasicNft.s.sol
│   ├── Interactions.s.sol
├── src/
│   ├── BasicNFT.sol
│   ├── MoodNft.sol
├── test/
│   ├── BasicNftTest.t.sol
│   ├── MoodNftTest.t.sol
├── README.md
├── foundry.toml (assumed)
├── .env (optional, for deployment)
```

## License
This project is licensed under the MIT License. See the `SPDX-License-Identifier: MIT` in each file for details.