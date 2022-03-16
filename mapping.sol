// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract Mapping{
    // stores value in key value pairs
    // mapping (KeyType => ValueType) mappingName;
    
    // stores all the address, then query by Id
    mapping(uint=>address) public owners;

    // complex types such as struct , mapping, enum, contract type cannot be used as a key
    // while any type can be used as value for the keys
    
    // operations on mapping
    mapping(address=>uint) userLevel;
    
    // get the value associated to a specific key
    function currentLevel(address userAddress) public view returns (uint){
        return userLevel[userAddress];
    }
    // setter function
    function setUserLevel(address _user, uint _level)public {
        userLevel[_user] = _level;
    }

    // nested mapping
    mapping( uint=> mapping( address=>string ) ) ownerAndTheirNames;

    // getter function for nested mapping
    function getOwnerAndTheirNames(uint index, address userAddress) public view returns (string memory){
        return ownerAndTheirNames[index][userAddress];
    }

    // setter function
    function setOwnerAndTheirNames(uint index, address userAddress,string memory _name) public {
        ownerAndTheirNames[index][userAddress] =_name;
    }

    // Iterating through a mapping
    // mapping in solidity are not iterable
    // But if you want to iterate through the keys of the mapping you can store the keys in an array
    uint[] keys;
    mapping(uint=>address) addresses;   
}