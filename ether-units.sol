// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract Ethers{
    // ether is the native cryptocurrency of ethereum
    // Mostly used denominations of ether are 
    // 1. Wei
    // 2. GWei

    // 1 ether =10**18 wei
    // 1 ether =10**9 Gwei

    //  when a transaction is created on etherum the object contains
    // tx ={
    //     nonce,
    //     to,
    //     value,
    //     gasLimit,
    //     gasPrice
    // }

    // here value is the amount of ether to send in wei
    // gasLimit is the maximum amount of gas user is willing to spend for this transaction
    // gasPrice is the price per uint gas user is willing to pay (measured in GWei)
}