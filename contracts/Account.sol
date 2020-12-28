pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";

contract Account {
    event ChangeFood(uint num);
    event ChangeWood(uint num);
    event ChangeIron(uint num);
    event ChangeStone(uint num);
    event ChangeCoin(uint num);
    event ChangePopulationRestriction(uint num);
    event ChangePower(uint num);
    event LackOfResources();

    event ChangeCavalryNum(uint num);
    event ChangeInfantrNum(uint num);
    event ChangePikemenNum(uint num);
    event ChangeArcherNum(uint num);
    event ChangeCavalrylevel(uint8 level);
    event ChangeInfantrlevel(uint8 level);
    event ChangePikemenlevel(uint8 level);
    event ChangeArcherlevel(uint8 level);

    mapping (address => uint) public food;
    mapping (address => uint) public wood;
    mapping (address => uint) public iron;
    mapping (address => uint) public stone;
    mapping (address => uint) public coin;
    mapping (address => uint) public population;
    mapping (address => uint) public populationRestriction;
    mapping (address => uint) public power;

    mapping (address => uint) public numOfCavalry;
    mapping (address => uint) public numOfInfantry;
    mapping (address => uint) public numOfPikemen;
    mapping (address => uint) public numOfArcher;

    mapping (address => uint8) public levelOfCavalry;
    mapping (address => uint8) public levelOfInfantry;
    mapping (address => uint8) public levelOfPikemen;
    mapping (address => uint8) public levelOfArcher;

    mapping (address => uint) public rockOwnerCount;
    mapping (address => uint) public oreOwnerCount;
    mapping (address => uint) public foodOwnerCount;
    mapping (address => uint) public coinOwnerCount;
    mapping (address => uint) public woodOwnerCount;

}