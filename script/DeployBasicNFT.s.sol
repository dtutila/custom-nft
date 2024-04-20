// SPDX-License-IdentifierP: MIT

pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract DeployBasicNFT is Script {
    function run() external returns (BasicNFT) {
        BasicNFT bnft;
        vm.startBroadcast();
        bnft = new BasicNFT();
        vm.stopBroadcast();

        return bnft;
    }
}
