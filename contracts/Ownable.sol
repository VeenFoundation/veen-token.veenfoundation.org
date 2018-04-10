pragma solidity ^0.4.18;
import "./SafeMath.sol";

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
 
contract Ownable {
  address public owner;
  address[] public owners;
  mapping(address => bool) public check_owner;
  mapping(address => uint256) public owners_dec;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
  using SafeMath for uint256;


  function Ownable() public {
    owners.push(msg.sender);
    owner = msg.sender;
    check_owner[msg.sender] =true;
  }


  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function multiOwner() public returns(bool){
      var count=0;
      var i=0;
      while(i<owners.length){
        if(owners_dec[owners[i]]==1){
          count += 1;

        }
        i+=1;
      }

      if(count > owners.length / 2){

          return true;

          }
      return false;


  }

  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

  function addOwnership(address newOwner) public onlyOwner {
    owners.push(newOwner);
    owners_dec[newOwner]=0;
    check_owner[newOwner]=true;

  }

}
