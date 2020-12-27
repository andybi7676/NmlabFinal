pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";

contract Account {
    
    mapping (address => uint) public rockOwnerCount;
    mapping (address => uint) public oreOwnerCount;
    mapping (address => uint) public foodOwnerCount;
    mapping (address => uint) public coinOwnerCount;
    mapping (address => uint) public woodOwnerCount;
    
}