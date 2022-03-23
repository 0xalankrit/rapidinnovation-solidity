// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721Receiver {
    function onERC721Received( address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
}
contract ERC721Holder is IERC721Receiver{
    function onERC721Received(
        address operator, 
        address from, 
        uint256 tokenId, 
        bytes calldata data) 
        external virtual override pure returns (bytes4){
        return type(IERC721Receiver).interfaceId;
    }
}