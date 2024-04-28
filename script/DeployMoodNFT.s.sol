// SPDX-License-IdentifierP: MIT

pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    string public constant HAPPY_SVG = "";
    string public constant SAD_SVG = "";
   
    function run() external returns (MoodNFT) {
        MoodNFT mnft;
        string memory happy = vm.readFile('./img/happyface.svg');
        string memory sad = vm.readFile('./img/sadface.svg');
        vm.startBroadcast();
        mnft = new MoodNFT(
            svgToImageURI(happy), 
            svgToImageURI(sad)
        );
        vm.stopBroadcast();
        //console.log(svgToImageURI(happy));
        //console.log(svgToImageURI(sad));
        return mnft;
    }

      function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(abi.encodePacked(svg)) 
        );
        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}
