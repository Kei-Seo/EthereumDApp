// SPDX-License-Identifier: MIT
pragma solidity ^0.5.13;

contract SimpleExampleMapping {
    mapping (uint => bool) public uintAddress;
    mapping (address => uint ) public eachAddressBalance;

    function simpleAddress(uint _uint) public {
        uintAddress[_uint] = true;
    }

    function sendMoney() public payable  {
        eachAddressBalance[msg.sender] += msg.value;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdrawAllMoney(address payable _to) public {
        uint amount = eachAddressBalance[msg.sender];
        eachAddressBalance[msg.sender] = 0;
        _to.transfer(amount);
    }
}
