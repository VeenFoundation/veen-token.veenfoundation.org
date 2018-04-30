pragma solidity ^0.4.18;

/*

    Copyright 2018, All rights reserved.
     _      _
    \ \    / / ___   ___  _ __
     \ \  / / / _ \ / _ \| '_ \
      \ \/ / |  __/|  __/| | | |
       \__/   \___| \___||_| |_|

    @title Veen Token Contract.
    @author Dohyeon Lee
    @description ERC-20 Interface

*/

contract ERC223ReceivingContract {

    function tokenFallback(address _from, uint _value, bytes _data) public;


}
