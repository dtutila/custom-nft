// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MoodNFT is ERC721 {

    constructor () ERC721("Mood", "MN") {

    }

}