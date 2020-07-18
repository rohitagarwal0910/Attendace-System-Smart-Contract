pragma solidity ^0.6.11;
//"SPDX-License-Identifier: UNLICENSED"

contract ERC20Token {
    string _name;
    string _symbol;
    uint8 _decimals;
    uint256 _totalSupply;
    
    mapping(address => uint256) _balances;
    mapping(address => mapping(address => uint256)) _allowances;
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    constructor(string memory name, string memory symbol, uint8 decimals, uint256 initialAmount) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _totalSupply = initialAmount;
        _balances[msg.sender] = initialAmount;
        emit Transfer(address(0), msg.sender, initialAmount);
    }
    
    function name() public view returns (string memory) {
        return _name;
    }
    
    function symbol() public view returns (string memory) {
        return _symbol;
    }
    
    function decimals() public view returns (uint8) {
        return _decimals;
    }
    
    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }
    
    function balanceOf(address _owner) public view returns (uint256) {
        return _balances[_owner];
    }
    
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_balances[msg.sender] >= _value, "Insufficient balance");
        require(_to != address(0), "Receiver is zero address");
        _balances[msg.sender] -= _value;
        _balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_from != address(0), "Sending from zero address");
        require(_to != address(0), "Receiver is zero address");
        require(_allowances[_from][msg.sender] >= _value, "Insufficient allowance");
        require(_balances[_from] >= _value, "Insufficient balance in owner's account");
        _balances[_from] -= _value;
        _balances[_to] += _value;
        _allowances[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint256 _value) public returns (bool) {
        require(_spender != address(0), "Spender is zero address");
        _allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256) {
        require(_owner != address(0), "Owner is zero address");
        require(_spender != address(0), "Spender is zero address");
        return _allowances[_owner][_spender];
    }
    
}