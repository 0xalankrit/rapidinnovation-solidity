// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;
contract Functions{
    // There are fourr type of solidity functions
    // external : this function can not be called inside the same contract or 
    //            from the contract inheriting this contract
    // public : any one can call this function (externally owner address , other function in the same contract)
    // private : noone can call this function except the function defined in the samae contract
    // internal : no externally owner account or contract that dont inherit from this contract can call this function
    address owner;
    mapping(uint =>address) public owners;

    constructor(){
        owner =msg.sender;
    }
    function callmeexteral(uint _value) external view returns (address){
        return owners[_value];
    }
    function callmepublic(uint _value) public view returns (address){
        return owners[_value];
    }
    function callmeprivate(uint _value) private view returns (address){
        return owners[_value];
    }
    function callmeinternal(uint _value) internal view returns (address){
        return owners[_value];
    }

    // view and pure visibility     

    // when a function's logic doesn't change any state variable we need to use pure visibilty for the function
    // calling this function won't change the state of the blockchain thus it won't cost any gasfee
    function iampure(uint _a,uint _b) public pure returns(uint){
        return _a+_b;
    } 
    // view : if we just want to read the value of a state variable 
    function getowner(uint _value) public view returns(address){
        return owners[_value];
    }
    // To change the way functions work, we can use Solidity modifiers. 
    // By using them, we can set a condition to check before the function execution. 
    
    modifier isOwner(){
        require(msg.sender ==owner,"Caller is not the owner");
        _;
        // _; this specifies the rest of the code of the function
    }
    function changeOwner(address _newowner) public isOwner {
        // before running this statement require statement of isOwner modifier should be checked;
        owner =_newowner;
    }

    modifier correctowner(uint _index){
        address(owners[_index]) ==owners[_index];
        _;
    }

    // payable function are the function which can recive ethers
    function a(address _address) public  payable{
        // as we are using msg.value global varible inside this function you must call this function with some ether
        // hence payable
        (bool result,) =_address.call{value:msg.value}('');
        require(result,"call failed");
    }

    // fallback functions
    // these are special functions in solidity, can only have external visibility and does not return annything
    // ARE OF TWO USES
    // 1. if this contract is called with a function signature that dosen't exist in this contract fallback fun is triggered
    // 2. If you send some ether to this contract fallback fun is triggered (hence it should be declared payable)

    event Doesnotexist(bytes datarecived);
    
    fallback() external payable{
        bytes memory _data =msg.data;
        emit Doesnotexist(_data);
    }
}