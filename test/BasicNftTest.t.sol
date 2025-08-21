// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNFT.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant VEEFOURHRC =
        "https://ipfs.io/ipfs/QmQvDNeHPbmwcHHuX9G3b7VwAQV1pbZbtyg8576CxeMr2S";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "VeeFour";
        string memory actualName = basicNft.name();

        // We can't compare an array of bytes (string) with another array of bytes. We can only compare primitive types
        // This means we can't compare strings with each other
        // We can compare the hash of each string using abi.encode

        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);

        basicNft.mintNft(VEEFOURHRC);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(VEEFOURHRC)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
