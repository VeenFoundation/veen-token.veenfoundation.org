pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Veen.sol";
import "../contracts/library/SafeMath.sol";

contract TestVeenERC20 {
    using SafeMath for uint;
    Veen veen = Veen(DeployedAddresses.Veen());

    function testTotalSupply() public {
        uint _totalSupply = veen.totalSupply();
        uint expected = 15000000000;
        Assert.equal(_totalSupply, expected, "The total supply of veen tokens must be 15,000,000,000");
    }
}