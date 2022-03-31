// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";


contract MyToken is ERC721, Ownable ,EIP712 {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    string private constant SIGNING_DOMAIN_NAME="MyDapp";
    string private constant SIGNING_DOMAIN_VERSION="1";

    mapping(uint256 =>bool) public usedNonce;
    constructor() ERC721("MyToken", "MTK") EIP712(SIGNING_DOMAIN_NAME,SIGNING_DOMAIN_VERSION) {}

    function safeMint(address to,uint256 id, string memory name, bytes memory signature) public {
        require(usedNonce[id]==false,"CANNOT_USE_THE_SAME_NONCE_TWICE");
        require(check(id,name,signature) ==owner(),"CAN_NOT_MINT");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        usedNonce[id]=true;
    }
    function check(uint256 id, string memory name, bytes memory signature) public view returns(address){
        return _verify(id,name,signature);
    }
    function _verify(uint256 id, string memory name, bytes memory signature) view internal returns(address){
        bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(
          keccak256("web3struct(uint256 id,string name)"),
          id,
          keccak256(bytes(name))
        )));
        address signer = ECDSA.recover(digest, signature);
        return signer;
    }
}
