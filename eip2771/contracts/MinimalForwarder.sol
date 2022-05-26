// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

contract MinimalForwarder is EIP712 {
    using ECDSA for bytes32;
    

    bytes32 private constant _TYPEHASH =
        keccak256("ForwardRequest(address from,address to,uint256 value,uint256 gas,uint256 nonce,bytes data)");

    mapping(address => uint256) private _nonces;

    constructor() EIP712("MinimalForwarder", "0.0.1") {}

    function getNonce(address from) public view returns (uint256) {
        return _nonces[from];
    }

    function verify(address from, 
                    address to,
                    uint256 value, 
                    uint256 gas, 
                    uint256 nonce, 
                    bytes memory data, 
                    bytes calldata signature) public view returns (bool) {
        address signer = _hashTypedDataV4(
            keccak256(abi.encode(_TYPEHASH, from, to, value, gas, nonce, keccak256(data)))
        ).recover(signature);
        return _nonces[from] == nonce && signer == from;
    }

    function execute(address from, 
                    address to,
                    uint256 value, 
                    uint256 gas, 
                    uint256 nonce, 
                    bytes memory data, 
                    bytes calldata signature) public payable returns (bool, bytes memory)
    {
        require(verify(from, to, value, gas, nonce,data, signature), "MinimalForwarder: signature does not match request");
        _nonces[from] = nonce + 1;

        (bool success, bytes memory returndata) = to.call{gas: gas, value: value}(
            abi.encodePacked(data, from)
        );

        if (gasleft() <= gas / 63) {
                assembly {
                    invalid()
                }
        }

        return (success, returndata);
    }
}