pragma solidity >=0.4.21 <0.7.0;

contract Soldier {
    event ChangeFood(uint num);
    event ChangeWood(uint num);
    event ChangeIron(uint num);
    event ChangeStone(uint num);
    event ChangeGold(uint num);
    event ChangePopulationRestriction(uint num);
    event ChangePower(uint num);
    event LackOfResources();

    event ChangeCavalryNum(uint num);
    event ChangeInfantryNum(uint num);
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
    mapping (address => uint) public gold;
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

    function _cost(uint food, uint wood, uint iron, uint stone, uint gold) internal returns (bool){
        if(food[msg.sender]>=food && wood[msg.sender]>=wood && iron[msg.sender]>=iron && stone[msg.sender]>=stone && gold[msg.sender]>=gold){
            food[msg.sender] -= food;
            wood[msg.sender] -= wood;
            iron[msg.sender] -= iron;
            stone[msg.sender] -= stone;
            gold[msg.sender] -= gold;
            ChangeFood(food[msg.sender]);
            ChangeWood(wood[msg.sender]);
            ChangeIron(iron[msg.sender]);
            ChangeStone(stone[msg.sender]);
            ChangeGold(gold[msg.sender]);
            return true;
        }
        return false;
    }

    // Check population before create uint
    function createCavalry(uint number) public {
        uint foodCost = (30*levelOfCavalry[msg.sender] - 5) * number;
        uint ironCost = (20*levelOfCavalry[msg.sender] - 5) * number;
        uint goldCost = (25*levelOfCavalry[msg.sender] - 5) * number;

        if (_cost(foodCost, uint(0), ironCost, uint(0), goldCost)){
            numOfCavalry[msg.sender] += number;
            ChangeCavalryNum(numOfCavalry[msg.sender]);
        }
        else{
            LackOfResources();
        }
    }
    function createInfantry(uint number) public {
        uint ironCost = (20*levelOfInfantry[msg.sender] - 5) * number;
        uint stoneCost = (20*levelOfInfantry[msg.sender] - 5) * number;
        uint goldCost = (20*levelOfInfantry[msg.sender] - 5) * number;

        if (_cost(uint(0), uint(0), ironCost, stoneCost, goldCost)){
            numOfInfantry[msg.sender] += number;
            ChangeInfantryNum(numOfInfantry[msg.sender]);
        }
        else{
            LackOfResource();
        }
    }
    function createPikemen(uint number) public {
        uint woodCost = (15*levelOfPikemen[msg.sender] - 5) * number;
        uint stoneCost = (25*levelOfPikemen[msg.sender] - 5) * number;
        uint goldCost = (20*levelOfPikemen[msg.sender] - 5) * number;

        if (_cost(uint(0), woodCost, uint(0), stoneCost, goldCost)){
            numOfPikemen[msg.sender] += number;
            ChangePikemenNum(numOfPikemen[msg.sender]);
        }
        else{
            LackOfResource();
        }
    }
    function createArcher(uint number) public {
        uint foodCost = (10*levelOfArcher[msg.sender] - 5) * number;
        uint woodCost = (30*levelOfArcher[msg.sender] - 5) * number;
        uint goldCost = (18*levelOfArcher[msg.sender] - 5) * number;

        if (_cost(foodCost, woodCost, uint(0), uint(0), goldCost)){
            numOfArcher[msg.sender] += number;
            ChangeArcherNum(numOfArcher[msg.sender]);
        }
        else{
            LackOfResource();
        }
    }



    function upgradeCavalry() public{
        uint foodCost = 600*levelOfCavalry[msg.sender] - 150;
        uint ironCost = 400*levelOfCavalry[msg.sender] - 100;
        uint goldCost = 500*levelOfCavalry[msg.sender] - 125;

        if (_cost(foodcost, uint(0), ironCost, uint(0), goldCost)){
            levelOfCavalry[msg.sender]++;
            ChangeCavalrylevel(levelOfCavalry[msg.sender]);
        }
        else{
            LackOfResource();
        }


    }
    function upgradeInfantry() public{
        uint ironCost = 400*levelOfInfantry[msg.sender] - 100;
        uint stoneCost = 400*levelOfInfantry[msg.sender] - 100;
        uint goldCost = 400*levelOfInfantry[msg.sender] - 100;

        if (_cost(uint(0), uint(0), ironCost, stoneCost, goldCost)){
            levelOfInfantry[mag.sender]++;
            ChangeInfantrylevel(levelOfInfantry[msg.sender]);
        }
        else{
            LackOfResource();
        }
    }
    function upgradePikemen() public{
        uint woodCost = 300*levelOfPikemen[msg.sender] - 75;
        uint stoneCost = 500*levelOfPikemen[msg.sender] - 125;
        uint goldCost = 400*levelOfPikemen[msg.sender] - 100;

        if (_cost(uint(0), woodCost, uint(0), stoneCost, goldCost)){
            levelOfPikemen[mag.sender]++;
            ChangePikemenlevel(levelOfPikemen[msg.sender]);
        }
        else{
            LackOfResource();
        }
    }
    function upgradeArcher() public {
        uint foodCost = 200*levelOfArcher[msg.sender] - 50;
        uint woodCost = 600*levelOfArcher[msg.sender] - 150;
        uint goldCost = 360*levelOfArcher[msg.sender] - 90;

        if (_cost(foodcost, woodCost, uint(0), uint(0), goldCost)){
            levelOfArcher[mag.sender]++;
            ChangeArcherlevel(levelOfArcher[msg.sender]);
        }
        else{
            LackOfResource();
        }
    }
}