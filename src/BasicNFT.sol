// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToURI;

    constructor() ERC721("Dogie", "Dog") {
        s_tokenCounter = 0;
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        return s_tokenIdToURI[_tokenId];
    }

    function mintNFT(string memory _tokenURI) public {
        s_tokenIdToURI[s_tokenCounter] = _tokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }
}
