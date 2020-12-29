pragma solidity >=0.4.21 <0.7.0;

import "./Account.sol";

contract Soldier is Account{
    event ChangeCavalryNum(uint num);
    event ChangeInfantryNum(uint num);
    event ChangePikemenNum(uint num);
    event ChangeArcherNum(uint num);
    event ChangeCavalrylevel(uint8 level);
    event ChangeInfantrylevel(uint8 level);
    event ChangePikemenlevel(uint8 level);
    event ChangeArcherlevel(uint8 level);

    mapping (address => uint) public numOfCavalry;
    mapping (address => uint) public numOfInfantry;
    mapping (address => uint) public numOfPikemen;
    mapping (address => uint) public numOfArcher;

    mapping (address => uint8) public levelOfCavalry;
    mapping (address => uint8) public levelOfInfantry;
    mapping (address => uint8) public levelOfPikemen;
    mapping (address => uint8) public levelOfArcher;

    function _updatePower() internal{
        power[msg.sender] = numOfCavalry[msg.sender]*levelOfCavalry + numOfInfantry[msg.sender]*levelOfInfantry
                            + numOfPikemen[msg.sender]*levelOfPikemen + numOfArcher[msg.sender]*levelOfArcher;
    }

    function createCavalry(uint number) internal {
        uint foodCost = (30*levelOfCavalry[msg.sender] - 5) * number;
        uint ironCost = (20*levelOfCavalry[msg.sender] - 5) * number;
        uint coinCost = (25*levelOfCavalry[msg.sender] - 5) * number;

        if (_cost(foodCost, uint(0), ironCost, uint(0), coinCost)){
            numOfCavalry[msg.sender].add(number);
            ChangeCavalryNum(numOfCavalry[msg.sender]);
            _updatePower();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function createInfantry(uint number) internal {
        uint ironCost = (20*levelOfInfantry[msg.sender] - 5) * number;
        uint stoneCost = (20*levelOfInfantry[msg.sender] - 5) * number;
        uint coinCost = (20*levelOfInfantry[msg.sender] - 5) * number;

        if (_cost(uint(0), uint(0), ironCost, stoneCost, coinCost)){
            numOfInfantry[msg.sender].add(number);
            ChangeInfantryNum(numOfInfantry[msg.sender]);
            _updatePower();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function createPikemen(uint number) internal {
        uint woodCost = (15*levelOfPikemen[msg.sender] - 5) * number;
        uint stoneCost = (25*levelOfPikemen[msg.sender] - 5) * number;
        uint coinCost = (20*levelOfPikemen[msg.sender] - 5) * number;

        if (_cost(uint(0), woodCost, uint(0), stoneCost, coinCost)){
            numOfPikemen[msg.sender].add(number);
            ChangePikemenNum(numOfPikemen[msg.sender]);
            _updatePower();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function createArcher(uint number) internal {
        uint foodCost = (10*levelOfArcher[msg.sender] - 5) * number;
        uint woodCost = (30*levelOfArcher[msg.sender] - 5) * number;
        uint coinCost = (18*levelOfArcher[msg.sender] - 5) * number;

        if (_cost(foodCost, woodCost, uint(0), uint(0), coinCost)){
            numOfArcher[msg.sender].add(number);
            ChangeArcherNum(numOfArcher[msg.sender]);
            _updatePower();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }



    function upgradeCavalry() internal{
        uint foodCost = 600*levelOfCavalry[msg.sender] - 150;
        uint ironCost = 400*levelOfCavalry[msg.sender] - 100;
        uint coinCost = 500*levelOfCavalry[msg.sender] - 125;

        if (_cost(foodCost, uint(0), ironCost, uint(0), coinCost)){
            levelOfCavalry[msg.sender]++;
            ChangeCavalrylevel(levelOfCavalry[msg.sender]);
            _updatePower();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }


    }
    function upgradeInfantry() internal{
        uint ironCost = 400*levelOfInfantry[msg.sender] - 100;
        uint stoneCost = 400*levelOfInfantry[msg.sender] - 100;
        uint coinCost = 400*levelOfInfantry[msg.sender] - 100;

        if (_cost(uint(0), uint(0), ironCost, stoneCost, coinCost)){
            levelOfInfantry[msg.sender]++;
            ChangeInfantrylevel(levelOfInfantry[msg.sender]);
            _updatePower();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function upgradePikemen() internal{
        uint woodCost = 300*levelOfPikemen[msg.sender] - 75;
        uint stoneCost = 500*levelOfPikemen[msg.sender] - 125;
        uint coinCost = 400*levelOfPikemen[msg.sender] - 100;

        if (_cost(uint(0), woodCost, uint(0), stoneCost, coinCost)){
            levelOfPikemen[msg.sender]++;
            ChangePikemenlevel(levelOfPikemen[msg.sender]);
            _updatePower();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function upgradeArcher() internal {
        uint foodCost = 200*levelOfArcher[msg.sender] - 50;
        uint woodCost = 600*levelOfArcher[msg.sender] - 150;
        uint coinCost = 360*levelOfArcher[msg.sender] - 90;

        if (_cost(foodCost, woodCost, uint(0), uint(0), coinCost)){
            levelOfArcher[msg.sender]++;
            ChangeArcherlevel(levelOfArcher[msg.sender]);
            _updatePower();
            ChangePower(power[msg.sender]);

        }
        else{
            LackOfResources();
        }
    }
}