//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import './ERC2981Base.sol';

contract NFTContract is ERC721, ERC2981Base
{
    uint256 nextTokenId;
    RoyaltyInfo private _royalties;

    constructor(string memory name_, string memory symbol_)
        ERC721(name_, symbol_)
    {}


    // value percentage (using 2 decimals - 10000 = 100, 0 = 0)
    function setRoyalties(address recipient, uint256 value) public {
        require(value <= 10000, 'ERC2981Royalties: Too high');
        _royalties = RoyaltyInfo(recipient, uint24(value));
    }

    function royaltyInfo(uint256, uint256 value)
        external
        view
        override
        returns (address receiver, uint256 royaltyAmount)
    {
        RoyaltyInfo memory royalties = _royalties;
        receiver = royalties.recipient;
        royaltyAmount = (value * royalties.amount) / 10000;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, ERC2981Base)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }


    function mint(address to) external {
        uint256 tokenId = nextTokenId;
        _safeMint(to, tokenId, '');

        nextTokenId = tokenId + 1;
    }

}
