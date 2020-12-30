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

    function _updatePower(address _owner) internal {
        power[_owner] = numOfCavalry[_owner]*levelOfCavalry[_owner] + numOfInfantry[_owner]*levelOfInfantry[_owner]
                            + numOfPikemen[_owner]*levelOfPikemen[_owner] + numOfArcher[_owner]*levelOfArcher[_owner];
    }

    function createCavalry(address _owner, uint number) internal returns(bool) {
        uint foodCost = (30*levelOfCavalry[_owner] - 5) * number;
        uint ironCost = (20*levelOfCavalry[_owner] - 5) * number;
        uint coinCost = (25*levelOfCavalry[_owner] - 5) * number;

        if (_cost(foodCost, uint(0), ironCost, uint(0), coinCost)){
            numOfCavalry[_owner].add(number);
            _updatePower(_owner);
            return true;
        }
        else{
            return false;
        }
    }
    function createInfantry(address _owner, uint number) internal returns(bool) {
        uint ironCost = (20*levelOfInfantry[_owner] - 5) * number;
        uint stoneCost = (20*levelOfInfantry[_owner] - 5) * number;
        uint coinCost = (20*levelOfInfantry[_owner] - 5) * number;

        if (_cost(uint(0), uint(0), ironCost, stoneCost, coinCost)){
            numOfInfantry[_owner].add(number);
            _updatePower(_owner);
            return true;
        }
        else{
            return false;
        }
    }
    function createPikemen(address _owner, uint number) internal returns(bool) {
        uint woodCost = (15*levelOfPikemen[_owner] - 5) * number;
        uint stoneCost = (25*levelOfPikemen[_owner] - 5) * number;
        uint coinCost = (20*levelOfPikemen[_owner] - 5) * number;

        if (_cost(uint(0), woodCost, uint(0), stoneCost, coinCost)){
            numOfPikemen[_owner].add(number);
            _updatePower(_owner);
            return true;
        }
        else{
            return false;
        }
    }
    function createArcher(address _owner, uint number) internal returns(bool) {
        uint foodCost = (10*levelOfArcher[_owner] - 5) * number;
        uint woodCost = (30*levelOfArcher[_owner] - 5) * number;
        uint coinCost = (18*levelOfArcher[_owner] - 5) * number;

        if (_cost(foodCost, woodCost, uint(0), uint(0), coinCost)){
            numOfArcher[_owner].add(number);
            _updatePower(_owner);
            return true;
        }
        else{
            return false;
        }
    }



    function upgradeCavalry(address _owner) internal returns(bool){
        uint foodCost = 600*levelOfCavalry[_owner] - 150;
        uint ironCost = 400*levelOfCavalry[_owner] - 100;
        uint coinCost = 500*levelOfCavalry[_owner] - 125;

        if (_cost(foodCost, uint(0), ironCost, uint(0), coinCost)){
            levelOfCavalry[_owner]++;
            _updatePower(_owner);
            return true;
        }
        else{
            return false;
        }


    }
    function upgradeInfantry(address _owner) internal returns(bool){
        uint ironCost = 400*levelOfInfantry[_owner] - 100;
        uint stoneCost = 400*levelOfInfantry[_owner] - 100;
        uint coinCost = 400*levelOfInfantry[_owner] - 100;

        if (_cost(uint(0), uint(0), ironCost, stoneCost, coinCost)){
            levelOfInfantry[_owner]++;
            _updatePower(_owner);
            return true;
        }
        else{
            return false;
        }
    }
    function upgradePikemen(address _owner) internal returns(bool){
        uint woodCost = 300*levelOfPikemen[_owner] - 75;
        uint stoneCost = 500*levelOfPikemen[_owner] - 125;
        uint coinCost = 400*levelOfPikemen[_owner] - 100;

        if (_cost(uint(0), woodCost, uint(0), stoneCost, coinCost)){
            levelOfPikemen[_owner]++;
            _updatePower(_owner);
            return true;
        }
        else{
            return false;
        }
    }
    function upgradeArcher(address _owner) internal returns(bool) {
        uint foodCost = 200*levelOfArcher[_owner] - 50;
        uint woodCost = 600*levelOfArcher[_owner] - 150;
        uint coinCost = 360*levelOfArcher[_owner] - 90;

        if (_cost(foodCost, woodCost, uint(0), uint(0), coinCost)){
            levelOfArcher[_owner]++;
            _updatePower(_owner);
            return true;
        }
        else{
            return false;
        }
    }
}