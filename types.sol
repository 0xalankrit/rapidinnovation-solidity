// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

contract Sample{
    uint a=10;
}
contract Types{
    // This is a comment
    // Value types includes :- boolean, integers, address ,contract types, fixed size byte array, etc
    // variables with value type are always copied when when passed to a function arguments.

    bool a=true;
    // uint8 stores value 0 to 255 (2**8-1)
    uint8 b=255; 
    uint256 c=100;
    // int (signed integer) stores value -128 to 127
    int8 d=-128;

    // address variable holds a 20 byte ethereum address;
    address e =0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // payable address can receive etheres
    address payable f;

    // contract type
    // All contracts define their type
    Sample _sample;

    // fixed size byte array ie: bytes1, bytes2, bytes3 .. bytes32
    bytes1 g =0x02;
    bytes2 h =0x2831;

    // dynamic size byte array
    // bytes and string (Reference type)
    string i ="hello";
    bytes j ="0x0029";

    // user defined type : enum
    enum direction { east,west,north,south }
    direction home;
    direction defaultdirection =direction.east;

    function gotowest() public{
        home =direction.west;
    }

    // Array

    // uninitialized
    uint[] array;
    // initialized
    uint[] public array2=[1,2,3];

    // Allocation arrays in memory :-
    function ff(uint len) public pure returns(uint[] memory){
        // using new keyword creates fixed size array in memory
        // size to know in prior
        uint[] memory array3 = new uint[](len);
        return array3;
    }

    // Operations on an array 
    
    // length :- get length of the array
    // push :- push an element in the end
    // pop :- pop an element fron the end
    // delete :- delete value from ann index (using delete won't reduce the size of the array
    // rather the value at the index is set to default. ie for uint ->0)

    
    function pushArray(uint _val) public{
        array2.push(_val);
    }

    function popArray() public{
        array2.pop();
    }

    function deleteValArray(uint _index) public{
        delete array2[_index];
    }

    // state variable, stored on the blockchain
    uint k =10;
    function callMe() public pure{
        // Local variable, stays local wrt the function
        // Destroyed when fun call is over
        uint l=10;
    }

}