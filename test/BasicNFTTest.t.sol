// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT deployer;
    BasicNFT nft;
    address alice = makeAddr("alice");
    uint256 private constant INITIAL_BALANCE = 10 ether;
    string private constant STRING_URI = "ipfs://aSDASdasdsadsad3";

    function setUp() public {
        deployer = new DeployBasicNFT();
        nft = deployer.run();
        vm.deal(alice, INITIAL_BALANCE);
    }

    modifier mintNFT() {
        vm.prank(alice);
        nft.mintNFT(STRING_URI);
        _;
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = nft.name();

        assertEq(keccak256(abi.encodePacked(expectedName)), keccak256(abi.encodePacked(actualName)));
    }

    function testMintNFT() public mintNFT {
        uint256 balance = nft.balanceOf(alice);

        assertEq(1, balance);
        assertEq(keccak256(abi.encodePacked(STRING_URI)), keccak256(abi.encodePacked(nft.tokenURI(0))));
    }
}
