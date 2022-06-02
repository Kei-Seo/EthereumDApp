pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract InJikToken is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    uint INITIAL_SUPPLY = 2000000;
    Counters.Counter private _tokenIds;

    constructor() public ERC721("InJik", "INJ") {
        _mint(msg.sender, INITIAL_SUPPLY * 10 ** uint(18));
    }

    function mint(address to, uint amount) public onlyOwner{
        _mint(to, amount);
    }

    function mintNFT(string memory tokenURI) public onlyOwner returns (uint256)
    {
        _tokenIds.increment();
        
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
