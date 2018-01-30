pragma solidity ^0.4.17;

import "./ERC20Token.sol";
import "./library/SafeMath.sol";

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

contract Veen is ERC20Token {
    using SafeMath for uint;

    string public constant name = "Veen";
    string public constant symbol = "VNC";
    uint8 public constant decimals = 18;

    uint private _tokenSupply;
    address private _owner;

    mapping(address => uint) private _balances;
    mapping(address => mapping(address => uint)) private _allowed;

    function Veen() public {
        _tokenSupply = 15000000000;
        _owner = msg.sender;
    }

    function totalSupply() public constant returns (uint) {
        return _tokenSupply;
    }

    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return _balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        if (tokens > 0 && balanceOf(to) >= tokens) {
            _balances[msg.sender] = _balances[msg.sender].sub(tokens);
            _balances[to] = _balances[to].add(tokens);
            Transfer(msg.sender, to, tokens);
            return true;
        }

        return false;
    }

    function approve(address spender, uint tokens) public returns (bool success) {
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

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        if (tokens > 0 && balanceOf(from) >= tokens && _allowed[from][msg.sender] >= tokens) {
            _balances[from] = _balances[from].sub(tokens);
            _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(tokens);
            _balances[to] = _balances[to].add(tokens);
            Transfer(msg.sender, to, tokens);
            return true;
        }
        return false;
    }
}