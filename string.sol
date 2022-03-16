// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract String{
    // string in solidity are dynamic size bytes array
    // can store data arbitary size
    // diff b/w string and bytes is that bytes store raw data in the form of byte
    // and string stores character (UTF-8 encoded)
    string s= "hello";
    // using string is expensive in terms of gas used
    // instead use fixed size bytes array ie bytes2,bytes4,bytes32
    bytes32 b ="hello"; 

    // bytes can be converted into string 
    bytes data ="0x013";
    string snew =string(data);

    // get the length of the string
    function length(string memory str) public pure returns(uint) {
        return bytes(str).length;
    }

    // concatenate two strings
    function concatenate(string memory string1,string memory string2) public pure returns(string memory) {
        // abi.encodePacked encodes the data without padding
        return string(abi.encodePacked(string1, string2));
    }
    // compare two string
    // compare their hashes
    function compare(string memory string1,  string memory string2) public pure returns(bool){
        return keccak256(abi.encode(string1))==keccak256(abi.encode(string2));
    }
}