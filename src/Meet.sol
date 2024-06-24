// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts v5.0.0
pragma solidity ^0.8.20;

import {ERC721} from "lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

contract MeetContract is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;

    event TokenMinted(address indexed to, uint256 indexed tokenId, string uri);
    event TokenBurned(uint256 indexed tokenId);

    constructor() ERC721("Meet", "MET") Ownable() {
        _nextTokenId = 1; // Initializing the _nextTokenId to start from 1
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://www.example.com/"; // Added https for a more realistic URL
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        emit TokenMinted(to, tokenId, uri);
    }

    function burn(uint256 tokenId) public override(ERC721Burnable, ERC721) {
        super.burn(tokenId);
        emit TokenBurned(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    // Ensures that functions in ERC721URIStorage and other inherited contracts are properly overridden
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}
