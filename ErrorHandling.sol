// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract ErrorHandling {
    // Solidity has functions designed for reverting state changes to prevent possible issues. 
    // Solidity deals with errors by reverting any changes done to state with exceptions.
    mapping(uint=>uint) internal balance;
    address blue=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    function addtobalance(uint _index, uint _amount) internal{
        require(_amount>0,"No amount provided");
        require(msg.sender == blue,"Can not call this fun");
        balance[_index]+=_amount;
    }

    // You can also use Solidity revert function to generate exceptions to display an error and 
    // redo the current call.

    function buy(uint amount) public payable {
        if (amount > msg.value / 2 ether)
            revert("Not enough Ether provided.");
        // Alternative way to do it:
        require(
            amount <= msg.value / 2 ether,
            "Not enough Ether provided."
        );
        // Perform the purchase.
    }

    // We uses assert for internal errors
    function sendHalf(address payable addr) public payable returns (uint balance) {
        require(msg.value % 2 == 0, "Even value required.");
        uint balanceBeforeTransfer = address(this).balance;
        addr.transfer(msg.value / 2);
        // Since transfer throws an exception on failure and
        // cannot call back here, there should be no way for us to
        // still have half of the money.
        assert(address(this).balance == balanceBeforeTransfer - msg.value / 2);
        return address(this).balance;
    }
}
