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

interface ERC20Token {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
