// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract Parent {
    uint internal v_a=10;
    uint internal v_b;
    constructor(uint _v_b){
        v_b=_v_b;
    }
    function f_a() public view returns(uint){
        return v_a;
    }
    function overrideMe() public virtual pure returns(string memory){
        return "Called from parent";
    }
    function overrideMe2() public virtual pure returns(string memory){
        return "Called from parent";
    }
}
contract Child is Parent(15){
    constructor(){}
    function getVal8() public view returns(uint){
        return v_a;
    }
    // Here we override parents overrideMe function using override keyword
    function overrideMe() public override pure returns(string memory){
        return "Called from Child";
    }
    function overrideMe2() public override pure returns(string memory){
        // using super keyword we can call parent contract
        super.overrideMe2();
        return "Called from Child";
    }

}

contract A{
    uint public a=10;
}
// correct way of shadowing Inherited State Variables
contract B is A{
    function changeVal() public {
        a=12;
    }
}
