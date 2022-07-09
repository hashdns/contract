// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract URC is ERC1155, Ownable{
    string public name;
    string public symbol;
    uint256 public maxSupply = 50;
    uint256 public maxMintAmount = 10;
    bool public paused = false;

    constructor() ERC1155("ipfs://bafybeiduswiq6veewvrjuyssfwtyg3thibdeeigimntmc2pmaowi56huqq/{id}.json") {
        name = "Nome da Colection";
        symbol = "Simbulo da moeda";
        mint(maxMintAmount);
    }


    function mint(uint256 _amount) public{

        for (uint256 i = 1; i < _amount; i++) {
            _mint(msg.sender, i, 1, "");
        }
    }

    function uri(uint256 _tokenId) public view virtual override returns (string memory) {
        return string(abi.encodePacked("ipfs://cid_do_json_aqui/", Strings.toString(_tokenId), ".json"));
    }
}