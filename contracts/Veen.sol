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
    string public constant symbol = "VNC";
    uint8 public constant decimals = 18;
    uint private i;
    uint private _tokenSupply;
    uint private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => uint256) private setup_list;
<<<<<<< HEAD
    mapping(address => mapping(address => uint256)) private _allowed;
=======
    //mapping(address => mapping(address => uint256)) private _allowed;
>>>>>>> b953b3b161b2e6809b8be72a96029010f5dec751

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

    function settle_vote(address vote_owner) public {
        if(check_owner[msg.sender]){
            owners_dec[msg.sender]=1;

        }
        else{
            throw;
        }
    }


    function settle(address[] add_list, uint256[] token_list) external  onlyOwner {

    i=0;
    uint256 sum=0;
    if(multiOwner()){


        while (i< add_list.length){
          _balances[add_list[i]] = _balances[add_list[i]].add(token_list[i]);
          sum = sum.add(token_list[i]);
          i+=1;
          TransferLog(msg.sender, add_list[i],token_list[i]);
        }
        _balances[owner] = _balances[owner].sub(sum);

        i=0;

        while(i<owners.length){
          owners_dec[owners[i]]=0;
          i+=1;
        }
      }


  }
  function setup(address to, uint256 token) onlyOwner external{

        setup_list[to]=token;


  }
<<<<<<< HEAD
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
=======

  function request(uint256 token) public{

        if(token > 0 && setup_list[msg.sender] > token){
>>>>>>> b953b3b161b2e6809b8be72a96029010f5dec751

            setup_list[msg.sender] = setup_list[msg.sender].sub(token);
            _balances[owner] = _balances[owner].sub(token);
            _balances[msg.sender] = _balances[msg.sender].add(token);
            Transfer(owner, msg.sender, token);
<<<<<<< HEAD
            return true;

        }
        else{
            return false;
=======


        }
        else{
          throw;
>>>>>>> b953b3b161b2e6809b8be72a96029010f5dec751
        }


  }
<<<<<<< HEAD

=======
/*
>>>>>>> b953b3b161b2e6809b8be72a96029010f5dec751
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
<<<<<<< HEAD

=======
*/
>>>>>>> b953b3b161b2e6809b8be72a96029010f5dec751
    function () public payable {
        throw;

    }
}
