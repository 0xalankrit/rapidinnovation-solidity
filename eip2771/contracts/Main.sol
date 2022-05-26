//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./ERC2771Context.sol";
import "hardhat/console.sol";

abstract contract Main is ERC2771Context{

    mapping(address =>string) public names;

    constructor(){}
    function updateName(string memory _name) public {
        names[_msgSender()]= _name;
    }
}
