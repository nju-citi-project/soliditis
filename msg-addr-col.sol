// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./MsgBox.sol";

contract MsgAddrCollection {
    mapping(address => address) private accountMsgBox;
    address private immutable owner;

    function getMsgBox(address account) public view returns (address) {
        require(msg.sender == owner, "You are not the owner");
        return accountMsgBox[account];
    }

    function addAddress(address account) public {
        require(msg.sender == owner, "You are not the owner");

        MsgBox newMsgBox = new MsgBox(); // 部署 MsgBox
        accountMsgBox[account] = address(newMsgBox); // 存储合约地址
    }

    constructor() {
        owner = msg.sender;
    }
}
