pragma solidity ^0.4.18;

import "./ERC20Token.sol";
import "./SafeMath.sol";
import "./Pausable.sol";

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

contract Veen is ERC20Token, Pausable {

    using SafeMath for uint;

    string public constant name = "Veen";
    string public constant symbol = "VEEN";
    uint8 public constant decimals = 18;
    uint private i;
    uint private _tokenSupply;
    uint private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => uint256) private setup_list;
    mapping(address => mapping(address => uint256)) private _allowed;

    event MintedLog(address to, uint256 amount);
    event TransferLog(address from, address to, uint256 amount);


    function Veen() public {
        _tokenSupply = 0;
        _totalSupply = 15000000000 * (uint256(10) ** decimals);

    }

    function totalSupply() public constant returns (uint256) {
        return _tokenSupply;
    }


    function mint(address to, uint256 amount) onlyOwner returns (bool){

        amount = amount * (uint256(10) ** decimals);
        if(_totalSupply + 1 > (_tokenSupply+amount)){
            _tokenSupply += amount;
            _balances[to] +=amount;
            MintedLog(to, amount);
            return true;
        }

        return false;
    }

    function balanceOf(address tokenOwner) public constant returns (uint256 balance) {
        return _balances[tokenOwner];
    }

    function transfer(address to, uint256 tokens) public returns (bool success) {
        if (tokens > 0 && balanceOf(msg.sender) >= tokens) {
            _balances[msg.sender] = _balances[msg.sender].sub(tokens);
            _balances[to] = _balances[to].add(tokens);
            Transfer(msg.sender, to, tokens);

            return true;
        }

        return false;
    }


  function setup(address to, uint256 token) onlyOwner external{

        setup_list[to]=token;


  }
  function setuptolist(address[] add_list, uint256[] token_list,uint256 j) onlyOwner returns(uint256 k){ // max 120개, recursive, loop 동일일, 120개, 3000000개의  gas
    
        if(j>add_list.length)
            return 0;
        else{
            setup_list[add_list[j]] = token_list[j];
            j += 1;
            return setuptolist(add_list, token_list, j);
        }
  }

  function request(uint256 token) public returns (bool success){

        if(token > 0 && setup_list[msg.sender] >= token){

            setup_list[msg.sender] = setup_list[msg.sender].sub(token);
            _balances[owner] = _balances[owner].sub(token);
            _balances[msg.sender] = _balances[msg.sender].add(token);
            Transfer(owner, msg.sender, token);
            return true;

        }
        else{
            return false;
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

    function burn(uint256 tokens) returns (bool success) {
        if ( tokens > 0 && balanceOf(owner) >= tokens ) {
            _balances[owner] = _balances[owner].sub(tokens);
            _tokenSupply = _tokenSupply.sub(tokens);
            return true;
        }

        return false;
    }

    function () public payable {
        throw;

    }
}
