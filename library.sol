// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

// If you want to write general purpose stateless code that can be reused 
// we write it in library
// They can’t hold ethers (so can’t have a fallback function)
// Doesn’t allow payable functions (since they can’t hold ethers)
// Cannot inherit nor be inherited
// Can’t be destroyed 

library Math{
    function add(uint x, uint y) internal pure returns (uint) {
        require(x + y >= x, "integer overflow");
        return x+y;
    }
}
// If functions in the library are internal no need to deploy the library. It will be embeded with the contract 
// But if the functions defined are public or external you need to deploy the library and then link before deploying the contract

contract TestMath {
    using Math for uint;

    function testAdd(uint x, uint y) public pure returns (uint) {
        return x.add(y);
    }
}

// Event in solidity
// Blockchain keeps event parameters in transaction logs.
contract Payment{
    event FundRecived(address indexed _whofunded,uint _amount);
    event Called(address indexed _to, uint indexed _amount,bytes indexed _data);

    address owner;
    constructor() payable{
        owner=msg.sender;
        if(msg.value>0){
            emit FundRecived(msg.sender,msg.value);
        }
    }
    fallback() external payable{
        emit FundRecived(msg.sender,msg.value);
    }
    function call(address _to, uint _value) public payable{
        owner==msg.sender;
        (bool result,bytes memory _data) =(_to).call{ value: _value}('');
        require(result,"Failed to call");
        emit Called(_to,_value,_data);
    }
}