pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";

contract Account {
    event ChangeFood(uint num);
    event ChangeWood(uint num);
    event ChangeIron(uint num);
    event ChangeStone(uint num);
    event ChangeCoin(uint num);
    event ChangePower(uint num);
    event LackOfResources();


    mapping (address => uint) public foodOwnerCount;
    mapping (address => uint) public woodOwnerCount;
    mapping (address => uint) public ironOwnerCount;
    mapping (address => uint) public stoneOwnerCount;
    mapping (address => uint) public coinOwnerCount;
    mapping (address => uint) public power;


    function _cost(uint food, uint wood, uint iron, uint stone, uint coin) internal returns (bool){
        if((foodOwnerCount[msg.sender]>=food) && (woodOwnerCount[msg.sender]>=wood) && (ironOwnerCount[msg.sender]>=iron) && (stoneOwnerCount[msg.sender]>=stone) && (coinOwnerCount[msg.sender]>=coin)){
            foodOwnerCount[msg.sender] -= food;
            woodOwnerCount[msg.sender] -= wood;
            ironOwnerCount[msg.sender] -= iron;
            stoneOwnerCount[msg.sender] -= stone;
            coinOwnerCount[msg.sender] -= coin;
            ChangeFood(foodOwnerCount[msg.sender]);
            ChangeWood(woodOwnerCount[msg.sender]);
            ChangeIron(ironOwnerCount[msg.sender]);
            ChangeStone(stoneOwnerCount[msg.sender]);
            ChangeCoin(coinOwnerCount[msg.sender]);
            return true;
        }
        return false;
    }

}