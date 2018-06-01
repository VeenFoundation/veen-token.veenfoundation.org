pragma solidity ^0.4.18;

import "./ERC20Token.sol";
import "./SafeMath.sol";
import "./Pausable.sol";
import "./ERC223.sol";
import "./ERC223ReceivingContract.sol";

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
    uint private i;
    uint private _tokenSupply;
    uint private _totalSupply;
    uint public fee;
    mapping(address => uint256) private _balances;
    mapping(address => uint256) private setup_list;
    mapping(address => mapping(address => uint256)) private _allowed;

    event MintedLog(address to, uint256 amount);



    function Veen() public {
        _tokenSupply = 0;
        _totalSupply = 15000000000 * (uint256(10) ** decimals);
        fee = 0;
    }

    function totalSupply() public constant returns (uint256) {
        return _tokenSupply;
    }
    function set_Fee(uint256 _fee) public onlyOwner{

        fee = _fee;

    }


    function mint(address to, uint256 amount) onlyOwner public returns (bool){

        amount = amount * (uint256(10) ** decimals);
        if(_totalSupply + 1 > (_tokenSupply+amount)){
            _tokenSupply += amount;
            _balances[to] += amount;
            MintedLog(to, amount);
            return true;
        }

        return false;
    }

    function balanceOf(address tokenOwner) public constant returns (uint256 balance) {
        return _balances[tokenOwner];
    }

    function transfer(address to, uint tokens) whenNotPaused public {
          require(tokens <= _balances[msg.sender]);
          _balances[msg.sender] = _balances[msg.sender].sub(tokens);
          _balances[owner] = _balances[owner].add(tokens*fee);
          _balances[to] = _balances[to].add(tokens - (tokens*fee));
          Transfer(msg.sender, to, tokens - (tokens*fee)," ");

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

    function transferFrom(address from, address to, uint256 tokens) onlyOwner public returns (bool success) {
        if (tokens > 0 && balanceOf(from) >= tokens && _allowed[from][msg.sender] >= tokens) {
            _balances[from] = _balances[from].sub(tokens);
            _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(tokens);
            _balances[to] = _balances[to].add(tokens);
            Transfer(msg.sender, to, tokens," ");
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
