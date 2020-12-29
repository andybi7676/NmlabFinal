pragma solidity >=0.4.21 <0.7.0;

import "./Account.sol";

contract Soldier is Account{
    function _cost(uint food, uint wood, uint iron, uint stone, uint coin) internal returns (bool){
        if((food[msg.sender]>=food) && (wood[msg.sender]>=wood) && (iron[msg.sender]>=iron) && (stone[msg.sender]>=stone) && (coin[msg.sender]>=coin)){
            food[msg.sender] -= food;
            wood[msg.sender] -= wood;
            iron[msg.sender] -= iron;
            stone[msg.sender] -= stone;
            coin[msg.sender] -= coin;
            ChangeFood(food[msg.sender]);
            ChangeWood(wood[msg.sender]);
            ChangeIron(iron[msg.sender]);
            ChangeStone(stone[msg.sender]);
            ChangeCoin(coin[msg.sender]);
            return true;
        }
        return false;
    }

    function _powerChange() internal{
        power[msg.sender] = numOfCavalry[msg.sender]*levelOfCavalry + numOfInfantry[msg.sender]*levelOfInfantry
                            + numOfPikemen[msg.sender]*levelOfPikemen + numOfArcher[msg.sender]*levelOfArcher;
    }

    function createCavalry(uint number) public {
        uint foodCost = (30*levelOfCavalry[msg.sender] - 5) * number;
        uint ironCost = (20*levelOfCavalry[msg.sender] - 5) * number;
        uint coinCost = (25*levelOfCavalry[msg.sender] - 5) * number;

        if (_cost(foodCost, uint(0), ironCost, uint(0), coinCost)){
            numOfCavalry[msg.sender] += number;
            ChangeCavalryNum(numOfCavalry[msg.sender]);
            _powerChange();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function createInfantry(uint number) public {
        uint ironCost = (20*levelOfInfantry[msg.sender] - 5) * number;
        uint stoneCost = (20*levelOfInfantry[msg.sender] - 5) * number;
        uint coinCost = (20*levelOfInfantry[msg.sender] - 5) * number;

        if (_cost(uint(0), uint(0), ironCost, stoneCost, coinCost)){
            numOfInfantry[msg.sender] += number;
            ChangeInfantryNum(numOfInfantry[msg.sender]);
            _powerChange();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function createPikemen(uint number) public {
        uint woodCost = (15*levelOfPikemen[msg.sender] - 5) * number;
        uint stoneCost = (25*levelOfPikemen[msg.sender] - 5) * number;
        uint coinCost = (20*levelOfPikemen[msg.sender] - 5) * number;

        if (_cost(uint(0), woodCost, uint(0), stoneCost, coinCost)){
            numOfPikemen[msg.sender] += number;
            ChangePikemenNum(numOfPikemen[msg.sender]);
            _powerChange();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function createArcher(uint number) public {
        uint foodCost = (10*levelOfArcher[msg.sender] - 5) * number;
        uint woodCost = (30*levelOfArcher[msg.sender] - 5) * number;
        uint coinCost = (18*levelOfArcher[msg.sender] - 5) * number;

        if (_cost(foodCost, woodCost, uint(0), uint(0), coinCost)){
            numOfArcher[msg.sender] += number;
            ChangeArcherNum(numOfArcher[msg.sender]);
            _powerChange();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }



    function upgradeCavalry() public{
        uint foodCost = 600*levelOfCavalry[msg.sender] - 150;
        uint ironCost = 400*levelOfCavalry[msg.sender] - 100;
        uint coinCost = 500*levelOfCavalry[msg.sender] - 125;

        if (_cost(foodCost, uint(0), ironCost, uint(0), coinCost)){
            levelOfCavalry[msg.sender]++;
            ChangeCavalrylevel(levelOfCavalry[msg.sender]);
            _powerChange();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }


    }
    function upgradeInfantry() public{
        uint ironCost = 400*levelOfInfantry[msg.sender] - 100;
        uint stoneCost = 400*levelOfInfantry[msg.sender] - 100;
        uint coinCost = 400*levelOfInfantry[msg.sender] - 100;

        if (_cost(uint(0), uint(0), ironCost, stoneCost, coinCost)){
            levelOfInfantry[msg.sender]++;
            ChangeInfantrylevel(levelOfInfantry[msg.sender]);
            _powerChange();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function upgradePikemen() public{
        uint woodCost = 300*levelOfPikemen[msg.sender] - 75;
        uint stoneCost = 500*levelOfPikemen[msg.sender] - 125;
        uint coinCost = 400*levelOfPikemen[msg.sender] - 100;

        if (_cost(uint(0), woodCost, uint(0), stoneCost, coinCost)){
            levelOfPikemen[msg.sender]++;
            ChangePikemenlevel(levelOfPikemen[msg.sender]);
            _powerChange();
            ChangePower(power[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function upgradeArcher() public {
        uint foodCost = 200*levelOfArcher[msg.sender] - 50;
        uint woodCost = 600*levelOfArcher[msg.sender] - 150;
        uint coinCost = 360*levelOfArcher[msg.sender] - 90;

        if (_cost(foodCost, woodCost, uint(0), uint(0), coinCost)){
            levelOfArcher[msg.sender]++;
            ChangeArcherlevel(levelOfArcher[msg.sender]);
            _powerChange();
            ChangePower(power[msg.sender]);

        }
        else{
            LackOfResources();
        }
    }
}