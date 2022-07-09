// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";

contract Out4surf is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 public mintRate = 0.05 ether;
    uint public MAX_SUPPLY = 10000;

    constructor() ERC721("Out4surf", "O4S") {}

    function safeMint(address to) public payable{
        require(totalSupply() < MAX_SUPPLY, "Can't mint more.");
        require(msg.value >= mintRate, "Not enough ether sent.");
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
        uri(tokenId);
        
    }
    
    function uri(uint256 _tokenId) public view virtual returns (string memory) {
        return string(abi.encodePacked("ipfs://bafybeiduswiq6veewvrjuyssfwtyg3thibdeeigimntmc2pmaowi56huqq/",
         Strings.toString(_tokenId), ".json"));
    }

    function price (uint _minRate) public onlyOwner {

        mintRate = _minRate;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function withdraw() public onlyOwner {
        require(address(this).balance > 0, "Balance is 0");
        payable(owner()).transfer(address(this).balance);
    }
}
