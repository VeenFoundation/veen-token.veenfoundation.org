pragma solidity ^0.4.18;
interface ERC223 {

    function totalSupply() public constant returns (uint);
    function balanceOf(address who) public constant returns (uint);
    function transfer(address to, uint value) public returns (bool);

}
