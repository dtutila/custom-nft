// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {

    error MoodNFT__CantFlipMoodifNotOwner();

    uint256 private s_tokenCounter;
    string private s_happyImageURI;
    string private s_sadImageURI;
    mapping(uint256 => Mood) s_tokenIdToMood;
    
    enum Mood {
        HAPPY,
        SAD
    }


    constructor (
        string memory _happyImageURI,
        string memory _sadImageURI
    ) ERC721("Mood", "MN") {
        s_happyImageURI = _happyImageURI;
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_sadImageURI = _sadImageURI;


    }
    function mintNFT() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNFT__CantFlipMoodifNotOwner();
        }

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    
        string memory imageURI = s_happyImageURI;

        if (s_tokenIdToMood[tokenId] == Mood.SAD) {
            imageURI = s_sadImageURI;
        }
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( 
                        abi.encodePacked(
                            '{"name":"',
                            name(), 
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    //getter and setters

    function getMood(uint256 tokenId) external view returns (uint256 mood) {
        return uint256(s_tokenIdToMood[tokenId]);
    }

}