// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;
import {Script} from "forge-std/Script.sol";
import {DeployBasicNFT} from "./DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNFT is Script {
    string private constant STRING_URI = "ipfs://aSDASdasdsadsad3";
    function run() external returns (BasicNFT) {
       address mostRecentBasicNFT = DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid);
        return mintNFTOnContract(mostRecentBasicNFT);
    }

    function mintNFTOnContract(address contractAddress) public returns (BasicNFT){

        vm.broadcast();
        BasicNFT(contractAddress).mintNFT(STRING_URI);
        vm.stopBroadcast;
        
    }

}