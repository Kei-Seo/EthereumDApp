pragma solidity ^0.5.12;

contract StartStopUpdateExample {
    address owner;
    bool pause;

    constructor() public {
        owner = msg.sender;
    } 

    function sendMoney() public payable {

    }

    function setPaused (bool _pause) public {
        pause = _pause;
    }

    function withdrawAllMoney( address payable _to ) public {
        require(owner == msg.sender, "You are not the owner");
        require(!pause, "Contract is pause!");
        _to.transfer(address(this).balance);
    }

    function destorySmartContract(address payable _to) public {
        require(owner == msg.sender);
        selfdestruct(_to);
    }
    

}
