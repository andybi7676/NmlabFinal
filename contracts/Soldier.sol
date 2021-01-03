pragma solidity >=0.4.21 <0.7.0;

import "./Account.sol";

contract Soldier is Account{
    mapping (address => uint) public numOfCavalry;
    mapping (address => uint) public numOfInfantry;
    mapping (address => uint) public numOfPikemen;
    mapping (address => uint) public numOfArcher;

    mapping (address => uint8) public levelOfCavalry;
    mapping (address => uint8) public levelOfInfantry;
    mapping (address => uint8) public levelOfPikemen;
    mapping (address => uint8) public levelOfArcher;

    mapping (address => uint) ownerStartCreateTime;
    mapping (address => uint) ownerCreateSoldierTime;
    mapping (address => string) ownerCreateSoldierName;
    mapping (address => uint) ownerStartLevelUpTime;
    mapping (address => string) ownerLevelUpSoldierName;
    uint createSoldierTime = 10;
    uint levelUpSoldierTime = 10;


    function _updatePower(address _owner) internal {
        power[_owner] = numOfCavalry[_owner]*levelOfCavalry[_owner] + numOfInfantry[_owner]*levelOfInfantry[_owner]
                            + numOfPikemen[_owner]*levelOfPikemen[_owner] + numOfArcher[_owner]*levelOfArcher[_owner];
    }

    function _createCavalry(address _owner, uint number) internal returns(bool) {
        uint foodCost = (30*levelOfCavalry[_owner] - 5) * number;
        uint ironCost = (20*levelOfCavalry[_owner] - 5) * number;
        uint coinCost = (25*levelOfCavalry[_owner] - 5) * number;

        return _cost(foodCost, uint(0), ironCost, uint(0), coinCost);
    }
    function _createInfantry(address _owner, uint number) internal returns(bool) {
        uint ironCost = (20*levelOfInfantry[_owner] - 5) * number;
        uint stoneCost = (20*levelOfInfantry[_owner] - 5) * number;
        uint coinCost = (20*levelOfInfantry[_owner] - 5) * number;

        return _cost(uint(0), uint(0), ironCost, stoneCost, coinCost);
    }
    function _createPikemen(address _owner, uint number) internal returns(bool) {
        uint woodCost = (15*levelOfPikemen[_owner] - 5) * number;
        uint stoneCost = (25*levelOfPikemen[_owner] - 5) * number;
        uint coinCost = (20*levelOfPikemen[_owner] - 5) * number;

        return _cost(uint(0), woodCost, uint(0), stoneCost, coinCost);
    }
    function _createArcher(address _owner, uint number) internal returns(bool) {
        uint foodCost = (10*levelOfArcher[_owner] - 5) * number;
        uint woodCost = (30*levelOfArcher[_owner] - 5) * number;
        uint coinCost = (18*levelOfArcher[_owner] - 5) * number;

        return _cost(foodCost, woodCost, uint(0), uint(0), coinCost);
    }



    function _upgradeCavalry(address _owner) internal returns(bool){
        uint foodCost = 600*levelOfCavalry[_owner] - 150;
        uint ironCost = 400*levelOfCavalry[_owner] - 100;
        uint coinCost = 500*levelOfCavalry[_owner] - 125;

        return _cost(foodCost, uint(0), ironCost, uint(0), coinCost);
    }
    function _upgradeInfantry(address _owner) internal returns(bool){
        uint ironCost = 400*levelOfInfantry[_owner] - 100;
        uint stoneCost = 400*levelOfInfantry[_owner] - 100;
        uint coinCost = 400*levelOfInfantry[_owner] - 100;

        return _cost(uint(0), uint(0), ironCost, stoneCost, coinCost);
    }
    function _upgradePikemen(address _owner) internal returns(bool){
        uint woodCost = 300*levelOfPikemen[_owner] - 75;
        uint stoneCost = 500*levelOfPikemen[_owner] - 125;
        uint coinCost = 400*levelOfPikemen[_owner] - 100;

        return _cost(uint(0), woodCost, uint(0), stoneCost, coinCost);
    }
    function _upgradeArcher(address _owner) internal returns(bool) {
        uint foodCost = 200*levelOfArcher[_owner] - 50;
        uint woodCost = 600*levelOfArcher[_owner] - 150;
        uint coinCost = 360*levelOfArcher[_owner] - 90;

        return _cost(foodCost, woodCost, uint(0), uint(0), coinCost);
    }

}