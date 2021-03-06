pragma solidity ^0.5.7;

// SPDX-License-Identifier: MIT

contract Setters_and_Getters { 
 
address public owner;
address public contractAddress;
uint public myNewNumber;

    constructor() public payable {
    owner = msg.sender;
    contractAddress = address(this);
    }
    
    function changeOwner(address payable _owner) public{
        require(msg.sender == owner);
    owner = _owner;
    }
    
    function addNumber (uint _addThisNumber) public { 
        myNewNumber = _addThisNumber + myNewNumber; 
    }

    function addTenToMyNumber() public view returns (uint) {
        return myNewNumber +10;
    }}