// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

// Abstract contracts
// contract should be marked as an abstract contract if atleast one of the function defined in it lacks implementation
// hence abstract contracts cannot be compiled 
abstract contract Person {
    function gender() public virtual returns (bytes32);
}

contract Employee is Person {
    function gender() public  pure override returns (bytes32) { return "female"; }
}

// interfaces are similar to abstract contract 
// in interface none of the function should be implemented
// other restrictions on interface
// -They cannot inherit from other contracts, but they can inherit from other interfaces.
// -All declared functions must be external.
// -They cannot declare a constructor.
// -They cannot declare state variables.
// -They cannot declare modifiers.

// interfaces can be converted to ABI without any data loss and vice versa

interface InterfaceExample{
    // Functions having only 
    // declaration not definition
    function getStr() external view returns(string memory);
    function setValue(uint _num1, uint _num2) external;
    function add() external view returns(uint);
}
// every function is virtual bydefault in interfae
// any no need to use override keywork in the overridding function in the inheriting contract
// Contract that implements interface
contract thisContract is InterfaceExample{
  
    // Private variables
    uint private num1;
    uint private num2;
  
    // Function definitions of functions 
    // declared inside an interface
    function getStr() public pure returns(string memory){
        return "GeeksForGeeks";
    }
      
     // Function to set the values 
    // of the private variables
    function setValue(uint _num1, uint _num2) public{
        num1 = _num1;
        num2 = _num2;
    }
      
    // Function to add 2 numbers 
    function add() public view returns(uint){
        return num1 + num2;
    }
}

contract call{
    function getValue(address _thiscontract) public returns(uint){
        InterfaceExample(_thiscontract).getStr();
        InterfaceExample(_thiscontract).setValue(10, 16);
        return  InterfaceExample(_thiscontract).add();
    }
}