// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;



import "../@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "../@openzeppelin/contracts/access/Ownable.sol";
import "../@openzeppelin/contracts/utils/Counters.sol";
import "../@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Out4Surf is ERC721, ERC721Enumerable, ERC721URIStorage, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;
    using SafeMath for uint256;

    Counters.Counter private _tokenIdCounter;
    uint256 public mintfee = 0.02 ether;
    uint public MAX_SUPPLY = 1000;
    uint public maxMintAmount = 10;

    constructor() ERC721("Out4Surf", "O4S") {}

    string baseURI="ipfs://bafybeidx7e4zqqrnkhk7iq4vgayanmjibwpghuqiunm254oseib76ubsry/";
    string public baseExtension = ".json";

        // Owner functions
    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function safeMint(address to, uint _amount) public payable{
        uint256 _mintfee;
        _mintfee = mintfee.mul(_amount);
        require(totalSupply() < MAX_SUPPLY, "Can't mint more.");
        require(_amount <= maxMintAmount, "Mint per transation <= 10");
        require(msg.value >= _mintfee, "Insulficient! Not enough ether sent.");
         for (uint256 i = 0; i < _amount; i++) {
        _tokenIdCounter.increment();    
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
        uri(tokenId);
        }
    }

    

    function uri(uint256 _tokenId) public view virtual returns (string memory) {
        return string(abi.encodePacked(baseURI, Strings.toString(_tokenId), ".json"));
    }

      function maxSupply (uint _maxSupply) public onlyOwner {

        MAX_SUPPLY = _maxSupply;
    }
                
    function mintFee (uint _mintfee) public onlyOwner {

        mintfee = _mintfee;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) onlyOwner {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
       require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        Strings.toString(tokenId),
                        baseExtension
                    )
                )
                : "";
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
