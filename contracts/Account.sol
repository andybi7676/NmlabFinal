pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";

contract Account {
    
    mapping (address => uint) public rockOwnerCount;
    mapping (address => uint) public oreOwnerCount;
    mapping (address => uint) public foodOwnerCount;
    mapping (address => uint) public coinOwnerCount;
    mapping (address => uint) public woodOwnerCount;
    
}