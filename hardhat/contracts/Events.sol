//SPDX-License-Identifier: UNLICENSED
// ERC-20 tokens are standard for fungible tokens. Each token are of similar value.

pragma solidity ^0.8.0;
contract DonateMe{
    event Thankyou(address who, uint256 value,bytes data);
    address payable public owner;
    constructor(){
        owner= payable(msg.sender);
    }
    fallback() payable external{
        emit Thankyou(msg.sender,msg.value,msg.data);
    }   
    function kill() public{
        require(msg.sender==owner);
        selfdestruct(owner);
    }
    function donationReceivedSoFar() view public returns(uint){
        return address(this).balance;
    }
}