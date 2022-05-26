// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";

import "./NFTAuction.sol";

contract Marketplace is Ownable{
    address nft;

    event AuctionCreated(NFTAuction nftAuction);

    constructor(address _nft){
        nft =_nft;
    }
    function createAuction(uint _nftId, uint _startingBid) public {
        address _owner =IERC721(nft).ownerOf(_nftId);
        require(_owner ==msg.sender,"You are not the owner of this nft");
        NFTAuction nftAuction = new NFTAuction(nft, _nftId,_startingBid,msg.sender); 
        emit AuctionCreated(nftAuction);
    }

    function retrieveFunds() public onlyOwner {
        (bool result, )= (msg.sender).call{value :address(this).balance}("");
        require(result,"Unable to call");
    }
}