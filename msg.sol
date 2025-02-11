// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MsgBox {
    address immutable private msgAccount;

    struct Msg {
        uint256 msgType; // 1是用户请求消息,2是用户发送attr消息,3是用户收到金融机构的消息
        bytes info;
    }

    Msg[] public msgs;

    constructor(address msgAcco) {
        msgAccount = msgAcco;
    }

    function getMsg(uint256 index)
        external
        view
        returns (uint256, bytes memory)
    {
        require(index < msgs.length, "Index out of bounds");

        Msg memory message = msgs[index];

        return (message.msgType, message.info);
    }
}


contract MsgAddrCollection {
    mapping(address => address) private accountMsgBox;
    address private immutable owner;

    function getMsgBox(address account) public view returns (address) {
        require(msg.sender == owner, "You are not the owner");
        return accountMsgBox[account];
    }

    function addAddress(address account) public returns (address) {
        require(msg.sender == owner, "You are not the owner");

        MsgBox newMsgBox = new MsgBox(account); // 部署 MsgBox
        accountMsgBox[account] = address(newMsgBox); // 存储合约地址
        return address(newMsgBox);
    }

    constructor() {
        owner = msg.sender;
    }
}