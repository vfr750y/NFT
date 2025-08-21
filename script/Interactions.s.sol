// SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNFT.sol";

contract MintBasicNft is Script {
    string public constant VEEFOURHRC =
        "https://ipfs.io/ipfs/QmQvDNeHPbmwcHHuX9G3b7VwAQV1pbZbtyg8576CxeMr2S";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(VEEFOURHRC);
        vm.stopBroadcast();
    }
}
