pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Veen.sol";
import "../contracts/library/SafeMath.sol";

contract TestVeenERC20 {
    using SafeMath for uint;
    Veen veen = Veen(DeployedAddresses.Veen());

    // addresses.
    address _owner = 0x627306090abaB3A6e1400e9345bC60c78a8BEf57; 
    address _client1 = 0xf17f52151EbEF6C7334FAD080c5704D77216b732;
    address _client2 = 0xC5fdf4076b8F3A5357c5E395ab970B5B54098Fef;
    address _client3 = 0x821aEa9a577a9b44299B9c15c88cf3087F3b5544;


    function testTotalSupply() public {
        uint _totalSupply = veen.totalSupply();
        uint expected = 15000000000;
        Assert.equal(_totalSupply, expected, "The total supply of veen tokens must be 15,000,000,000 VNC");
    }

    function testContractOwnerBalance() public {
        uint balanceOfOwner = veen.balanceOf(tx.origin);
        uint expected = 15000000000;
        Assert.equal(balanceOfOwner, expected, "The balance of contract creator must be 15,000,000,000 VNC");
    }
}