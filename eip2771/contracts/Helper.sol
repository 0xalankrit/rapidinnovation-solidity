//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "hardhat/console.sol";

 contract Helper {

    function callForwarder(address _minimalForwarder) public {
        (bool success,) = _minimalForwarder.call(abi.encodeWithSignature("execute(address from,address to,uint256 value,uint256 gas,uint256 nonce,bytes memory data, bytes calldata signature)"));
    }

}
