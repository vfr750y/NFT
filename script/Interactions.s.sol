// SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNFT.sol";

contract MintBasicNft is Script {
    string public constant VEEFOURHRC =
        "https://ipfs.io/ipfs/QmQvDNeHPbmwcHHuX9G3b7VwAQV1pbZbtyg8576CxeMr2S";

    // string public constant VEEFOURHRC =
    //    "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    /*  // Hardcode the deployed contract address
   // address public constant BASIC_NFT_ADDRESS =
   //     0x5FbDB2315678afecb367f032d93F642f64180aa3; // Replace with actual address

    function run() external {
        mintNftOnContract(BASIC_NFT_ADDRESS);
    }
*/
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
