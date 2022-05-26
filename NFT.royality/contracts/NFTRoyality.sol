//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import './ERC2981ContractWideRoyalties.sol';
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTC is ERC721, ERC2981ContractWideRoyalties, ERC721Burnable, Ownable {
    uint256 nextTokenId;

    constructor(string memory name_, string memory symbol_)
        ERC721(name_, symbol_)
    {}

    
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, ERC2981)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function setRoyalties(address recipient, uint256 value) public onlyOwner{
        _setRoyalties(recipient, value);
    }

    function unsetRoyalties(address recipient) public onlyOwner {
        _unsetRoyalties(recipient);
    }

    function mint(address to) external {
        uint256 tokenId = nextTokenId;
        _safeMint(to, tokenId);

        nextTokenId = tokenId + 1;
    }

}
