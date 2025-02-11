// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MsgAddrCollection {
    mapping (address => address) private accountMsgBox;
    address private owner;
     function getMsgBox(address account) public view
            returns (address msgAddr) {
                require(msg.sender == owner, "you are not the owner");
                msgAddr = accountMsgBox[account];
            }

    function addAddress(address account, address contractAddr) public  {
        require(msg.sender == owner, "you are not the owner");
        accountMsgBox[account] = contractAddr;
        
    }

    constructor() {
        owner = msg.sender;
    }
}