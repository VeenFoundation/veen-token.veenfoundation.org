pragma solidity ^0.4.18;

import "./ERC20Token.sol";
import "./SafeMath.sol";
import "./Pausable.sol";
import "./ERC223.sol";
import "./Receiver_Interface.sol";

/*
    Copyright 2018, All rights reserved.
     _      _
    \ \    / / ___   ___  _ __
     \ \  / / / _ \ / _ \| '_ \
      \ \/ / |  __/|  __/| | | |
       \__/   \___| \___||_| |_|

    @title Veen Token Contract.
    @author Dohyeon Lee
    @description Veen token is a ERC20-compliant token.

*/

contract Veen is ERC20Token, Pausable, ERC223{

    using SafeMath for uint;

    string public constant name = "Veen";
    string public constant symbol = "VEEN";
    uint8 public constant decimals = 18;
    uint private _tokenSupply;
    uint private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowed;
    event MintedLog(address to, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint value);


    function Veen() public {
        _tokenSupply = 0;
        _totalSupply = 15000000000 * (uint256(10) ** decimals);

    }

    function totalSupply() public constant returns (uint256) {
        return _tokenSupply;
    }

    function mint(address to, uint256 amount) onlyOwner public returns (bool){

        amount = amount * (uint256(10) ** decimals);
        if(_totalSupply + 1 > (_tokenSupply+amount)){
            _tokenSupply = _tokenSupply.add(amount);
            _balances[to]= _balances[to].add(amount);
            MintedLog(to, amount);
            return true;
        }

        return false;
    }

    function dist_list_set(address[] dist_list, uint256[] token_list) onlyOwner external{

        for(uint i=0; i < dist_list.length ;i++){
            transfer(dist_list[i],token_list[i]);
        }

    }
    function balanceOf(address tokenOwner) public constant returns (uint256 balance) {
        return _balances[tokenOwner];
    }

    function transfer(address to, uint tokens) whenNotPaused public returns(bool success){
    bytes memory empty;
    	if(isContract(to)) {
        	return transferToContract(to, tokens, empty);
    	}
    	else {
        	return transferToAddress(to, tokens, empty);
    	}
    }


    function approve(address spender, uint256 tokens) public returns (bool success) {

        if (tokens > 0 && balanceOf(msg.sender) >= tokens) {
            _allowed[msg.sender][spender] = tokens;
            Approval(msg.sender, spender, tokens);
            return true;
        }

        return false;
    }

    function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {
        return _allowed[tokenOwner][spender];
    }

    function transferFrom(address from, address to, uint256 tokens) public returns (bool success) {
        if (tokens > 0 && balanceOf(from) >= tokens && _allowed[from][msg.sender] >= tokens) {
            _balances[from] = _balances[from].sub(tokens);
            _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(tokens);
            _balances[to] = _balances[to].add(tokens);
            Transfer(msg.sender, to, tokens);
            return true;
        }
        return false;
    }

    function burn(uint256 tokens) public returns (bool success) {
        if ( tokens > 0 && balanceOf(msg.sender) >= tokens ) {
            _balances[msg.sender] = _balances[msg.sender].sub(tokens);
            _tokenSupply = _tokenSupply.sub(tokens);
            return true;
        }

        return false;
    }
  function transferToAddress(address _to, uint _value, bytes _data) private returns (bool success) {
    if (balanceOf(msg.sender) < _value) revert();
    _balances[msg.sender] = balanceOf(msg.sender).sub(_value);
    _balances[_to] = balanceOf(_to).add(_value);
    emit Transfer(msg.sender, _to, _value);
    return true;
  }
  
  //function that is called when transaction target is a contract
  function transferToContract(address _to, uint _value, bytes _data) private returns (bool success) {
    if (balanceOf(msg.sender) < _value) revert();
    _balances[msg.sender] = balanceOf(msg.sender).sub(_value);
    _balances[_to] = balanceOf(_to).add(_value);
    ContractReceiver receiver = ContractReceiver(_to);
    receiver.tokenFallback(msg.sender, _value, _data);
    emit Transfer(msg.sender, _to, _value);
    return true;
}



    function isContract(address _addr) view returns (bool is_contract){
      uint length;
      assembly {
            length := extcodesize(_addr)
      }
      return (length>0);
    }

    function () public payable {
        throw;

    }
}
