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
