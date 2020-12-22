pragma solidity >=0.4.21 <0.7.0;

contract Soldier {
    event ChangeFood(uint num);
    event ChangeWood(uint num);
    event ChangeIron(uint num);
    event ChangeGold(uint num);
    event ChangeStone(uint num);
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
    mapping (address => uint) public gold;
    mapping (address => uint) public stone;
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

    // Check population before create uint
    function createCavalry(uint number) public {
        uint foodCost = (30*levelOfCavalry[msg.sender] - 5) * number;
        uint ironCost = (20*levelOfCavalry[msg.sender] - 5) * number;
        uint goldCost = (25*levelOfCavalry[msg.sender] - 5) * number;

        if ((food[msg.sender] - foodCost >= 0) && (iron[msg.sender] - ironCost >= 0) && (gold[msg.sender] - goldCost >= 0)){
            food[msg.sender] -= foodCost;
            iron[msg.sender] -= ironCost;
            gold[msg.sender] -= goldCost;
            numOfCavalry[msg.sender] += number;
            ChangeFood(food[msg.sender]);
            ChangeIron(iron[msg.sender]);
            ChangeGold(gold[msg.sender]);
            ChangeCavalryNum(numOfCavalry[msg.sender]);
        }
        else{
            LackOfResource();
        }
    }
    function createInfantry(uint number) public {
        uint stoneCost = (20*levelOfInfantry[msg.sender] - 5) * number;
        uint ironCost = (20*levelOfInfantry[msg.sender] - 5) * number;
        uint goldCost = (20*levelOfInfantry[msg.sender] - 5) * number;

        if ((stone[msg.sender] - stoneCost >= 0) && (iron[msg.sender] - ironCost >= 0) && (gold[msg.sender] - goldCost >= 0)){
            stone[msg.sender] -= stoneCost;
            iron[msg.sender] -= ironCost;
            gold[msg.sender] -= goldCost;
            numOfInfantry[msg.sender] += number;
            ChangeStone(stone[msg.sender]);
            ChangeIron(iron[msg.sender]);
            ChangeGold(gold[msg.sender]);
            ChangeInfantryNum(numOfInfantry[msg.sender]);
        }
        else{
            LackOfResource();
        }
    }
    function createPikemen(uint number) public {
        uint stoneCost = (25*levelOfPikemen[msg.sender] - 5) * number;
        uint woodCost = (15*levelOfPikemen[msg.sender] - 5) * number;
        uint goldCost = (20*levelOfPikemen[msg.sender] - 5) * number;

        if ((stone[msg.sender] - stoneCost >= 0) && (wood[msg.sender] - woodCost >= 0) && (gold[msg.sender] - goldCost >= 0)){
            stone[msg.sender] -= stoneCost;
            wood[msg.sender] -= woodCost;
            gold[msg.sender] -= goldCost;
            numOfPikemen[msg.sender] += number;
            ChangeStone(stone[msg.sender]);
            ChangeWood(wood[msg.sender]);
            ChangeGold(gold[msg.sender]);
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

        if ((food[msg.sender] - foodCost >= 0) && (wood[msg.sender] - woodCost >= 0) && (gold[msg.sender] - goldCost >= 0)){
            food[msg.sender] -= foodCost;
            wood[msg.sender] -= woodCost;
            gold[msg.sender] -= goldCost;
            numOfArcher[msg.sender] += number;
            ChangeFood(food[msg.sender]);
            ChangeWood(wood[msg.sender]);
            ChangeGold(gold[msg.sender]);
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

        if ((food[msg.sender] - foodCost >= 0) && (iron[msg.sender] - ironCost >= 0) && (gold[msg.sender] - goldCost >= 0)){
            food[msg.sender] -= foodCost;
            iron[msg.sender] -= ironCost;
            gold[msg.sender] -= goldCost;
            levelOfCavalry[mag.sender]++;
            ChangeFood(food[msg.sender]);
            ChangeIron(iron[msg.sender]);
            ChangeGold(gold[msg.sender]);
            ChangeCavalrylevel(levelOfCavalry[msg.sender]);
        }
        else{
            LackOfResource();
        }


    }
    function upgradeInfantry() public{
        uint stoneCost = 400*levelOfInfantry[msg.sender] - 100;
        uint ironCost = 400*levelOfInfantry[msg.sender] - 100;
        uint goldCost = 400*levelOfInfantry[msg.sender] - 100;

        if ((stone[msg.sender] - stoneCost >= 0) && (iron[msg.sender] - ironCost >= 0) && (gold[msg.sender] - goldCost >= 0)){
            stone[msg.sender] -= stoneCost;
            iron[msg.sender] -= ironCost;
            gold[msg.sender] -= goldCost;
            levelOfInfantry[mag.sender]++;
            ChangeStone(stone[msg.sender]);
            ChangeIron(iron[msg.sender]);
            ChangeGold(gold[msg.sender]);
            ChangeInfantrylevel(levelOfInfantry[msg.sender]);
        }
        else{
            LackOfResource();
        }
    }
    function upgradePikemen() public{
        uint stoneCost = 500*levelOfPikemen[msg.sender] - 125;
        uint woodCost = 300*levelOfPikemen[msg.sender] - 75;
        uint goldCost = 400*levelOfPikemen[msg.sender] - 100;

        if ((stone[msg.sender] - stoneCost >= 0) && (wood[msg.sender] - woodCost >= 0) && (gold[msg.sender] - goldCost >= 0)){
            stone[msg.sender] -= stoneCost;
            wood[msg.sender] -= woodCost;
            gold[msg.sender] -= goldCost;
            levelOfPikemen[mag.sender]++;
            ChangeStone(stone[msg.sender]);
            ChangeWood(wood[msg.sender]);
            ChangeGold(gold[msg.sender]);
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

        if ((food[msg.sender] - foodCost >= 0) && (wood[msg.sender] - woodCost >= 0) && (gold[msg.sender] - goldCost >= 0)){
            food[msg.sender] -= foodCost;
            wood[msg.sender] -= woodCost;
            gold[msg.sender] -= goldCost;
            levelOfArcher[mag.sender]++;
            ChangeFood(food[msg.sender]);
            ChangeWood(wood[msg.sender]);
            ChangeGold(gold[msg.sender]);
            ChangeArcherlevel(levelOfArcher[msg.sender]);
        }
        else{
            LackOfResource();
        }
    }
}