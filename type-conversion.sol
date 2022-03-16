// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract Conversion{
    // there are two type of conversions implicit and explicit
    // Implicit type conversions automatically applied by the compiler
    // during assignments, when passing arguments to functions and when applying operators.

    // For implicit conversion data should not lost ,semantically correct
    // uint8 to uint16 is ok
    // int8 to uint64 not ok

    uint8 public a =10;
    uint16 public b= 20;
    uint32 public c=a+b;
    // result will be uint32
    // first a will be converter to uint16 implicitly, then added, then converted to uint32

    // Explicit conversions
    // force conversion by the developer 
    int8 public d=-3;
    uint8 public f =uint8(d);
    // f will store 253

    // If an integer is explicitly converted to a smaller type, higher-order bits are cut off:
    uint32 public g = 0x12345678;
    uint16 public h = uint16(g); 
    // h will be 0x5678 now

    // If an integer is explicitly converted to a larger type, it is padded on the left
    uint16 public i = 0x1234;
    uint32 public j = uint32(i); 
    // j will be 0x00001234 now


    // If an fixed size bytes array is explicitly converted to a smaller type, lower order bits are cut off
    bytes2 k = 0x1234;
    bytes1 l = bytes1(k); 
    // l will be 0x12

    // If an fixed size bytes array is explicitly converted to a larger type, it is padded to the right
    bytes2 m = 0x1234;
    bytes4 n = bytes4(m); 
    // n will be 0x12340000

}