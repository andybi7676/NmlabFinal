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
        uint foodCost = 30*levelOfCavalry[msg.sender] - 5;
        uint ironCost = 20*levelOfCavalry[msg.sender] - 5;
        uint goldCost = 25*levelOfCavalry[msg.sender] - 5;

        if ((food[msg.sender] % foodCost >= number) && (iron[msg.sender] % ironCost >= number) && (gold[msg.sender] % goldCost >= number)){
            food[msg.sender] -= foodCost*number;
            iron[msg.sender] -= ironCost*number;
            gold[msg.sender] -= goldCost*number;
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
        uint stoneCost = 20*levelOfInfantry[msg.sender] - 5;
        uint ironCost = 20*levelOfInfantry[msg.sender] - 5;
        uint goldCost = 20*levelOfInfantry[msg.sender] - 5;

        if ((stone[msg.sender] % stoneCost >= number) && (iron[msg.sender] % ironCost >= number) && (gold[msg.sender] % goldCost >= number)){
            stone[msg.sender] -= stoneCost*number;
            iron[msg.sender] -= ironCost*number;
            gold[msg.sender] -= goldCost*number;
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
        uint stoneCost = 25*levelOfPikemen[msg.sender] - 5;
        uint woodCost = 20*levelOfPikemen[msg.sender] - 5;
        uint goldCost = 20*levelOfPikemen[msg.sender] - 5;

        if ((stone[msg.sender] % stoneCost >= number) && (wood[msg.sender] % woodCost >= number) && (gold[msg.sender] % goldCost >= number)){
            stone[msg.sender] -= stoneCost*number;
            wood[msg.sender] -= woodCost*number;
            gold[msg.sender] -= goldCost*number;
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
        uint foodCost = 10*levelOfArcher[msg.sender] - 5;
        uint woodCost = 30*levelOfArcher[msg.sender] - 5;
        uint goldCost = 18*levelOfArcher[msg.sender] - 5;

        if ((food[msg.sender] % foodCost >= number) && (wood[msg.sender] % woodCost >= number) && (gold[msg.sender] % goldCost >= number)){
            food[msg.sender] -= foodCost*number;
            wood[msg.sender] -= woodCost*number;
            gold[msg.sender] -= goldCost*number;
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
        levelOfCavalry[mag.sender]++;
        ChangeCavalrylevel(levelOfCavalry[msg.sender]);
    }
    function upgradeInfantry() public{
        levelOfInfantry[mag.sender]++;
        ChangeInfantrylevel(levelOfInfantry[msg.sender]);
    }
    function upgradePikemen() public{
        levelOfPikemen[mag.sender]++;
        ChangePikemenlevel(levelOfPikemen[msg.sender]);
    }
    function upgradeArcher() public {
        levelOfArcher[mag.sender]++;
        ChangeArcherlevel(levelOfArcher[msg.sender]);
    }
}