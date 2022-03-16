// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract Structs{
    // with the help of struct we can make custom types in solidity
    // collection of variables
    struct Person{
        string name;
        uint age;
    }

    Person person1 =Person("Admin",20);
    function increaseAge(uint _age) public{
        person1.age =_age;
    }
    // The members of a struct can be of any type ie bool,uint bytes,string ,array

    // structs can be used inside a mapping and array as value type;
    mapping(uint =>Person) public persontable;
    Person[] public crowd;

    // Assigning a struct type to a local variable you have to you have to specify the data location
    // ie :- memory, calldata, storage

    // If used storage :it reference the state variable
    function modifypersonS() public{
        Person storage newperson =person1;
        // this will change the orignal person
        newperson.age=99;
    } 
    // if used memory : it uses the copy of the orignal variable. thus wont change the orignal value
    function modifypersonM() public view{
        Person memory newperson =person1;
        // orignal value remain same
        newperson.age =88;
    }

}