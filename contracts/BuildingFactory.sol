pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Account.sol";

contract BuildingFactory is Account {
    
    using SafeMath for uint;
    
    struct Building {
        string name;
        uint placeX;
        uint placeY;
        uint level;
    }

    uint buildTimeNeed = 10;
    Building[] public buildings;
    uint buildResourceNeed = 10;

    mapping (uint => address) public buildingToOwner;
    mapping (address => uint) ownerStartBuildTime;
    mapping (address => uint) ownerBuildingId; //the building that is building
    mapping (address => uint) castleLevel;

    mapping (address => uint) ownerFarmCount;
    mapping (address => uint) ownerMineCount;
    mapping (address => uint) ownerManorCount;
    mapping (address => uint) ownerQuarryCount;
    mapping (address => uint) ownerSawmillCount;
    mapping (address => uint) ownerCellarCount;
    mapping (address => uint) ownerBarrackCount;


    function createBuilding(string memory _name, uint _x, uint _y) public returns(uint){
        uint id = buildings.push(Building(_name, _x, _y, 1)).sub(1);
        _cost(0, buildResourceNeed, buildResourceNeed, buildResourceNeed, buildResourceNeed);
        buildingToOwner[id] = msg.sender;
        if (keccak256(bytes(_name)) == keccak256(bytes("Farm"))) {
            ownerFarmCount[msg.sender] = ownerFarmCount[msg.sender].add(1);
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Mine"))) {
            ownerMineCount[msg.sender] = ownerMineCount[msg.sender].add(1);
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Manor"))) {
            ownerManorCount[msg.sender] = ownerManorCount[msg.sender].add(1);
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Quarry"))) {
            ownerQuarryCount[msg.sender] = ownerQuarryCount[msg.sender].add(1);
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Sawmill"))) {
            ownerSawmillCount[msg.sender] = ownerSawmillCount[msg.sender].add(1);
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Cellar"))) {
            ownerCellarCount[msg.sender] = ownerCellarCount[msg.sender].add(1);
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Barrack"))) {
            ownerBarrackCount[msg.sender] = ownerBarrackCount[msg.sender].add(1);
        }
        return id;
    }

    function startBuild(address _owner, uint _x, uint _y) public returns(uint){
        uint buildingID = getBuildingByOwner(_owner, _x, _y);
        if (keccak256(bytes(buildings[buildingID].name)) != keccak256(bytes("Castle"))) {
            require(castleLevel[_owner] >= buildings[buildingID].level.add(1));
        }
        ownerBuildingId[_owner] = buildingID;
        ownerStartBuildTime[_owner] = now;
        uint buildingResourceNeed = buildings[buildingID].level * buildResourceNeed;
        _cost(0, buildingResourceNeed, buildingResourceNeed, buildingResourceNeed, buildingResourceNeed);
        return buildings[buildingID].level * buildTimeNeed;
    }
    
    function updateBuild(address _owner) public returns(uint){
        uint buildingID = ownerBuildingId[_owner];
        if (ownerStartBuildTime[_owner] != 0 && now >= ownerStartBuildTime[_owner] + buildings[buildingID].level * buildTimeNeed) {
            buildings[buildingID].level = buildings[buildingID].level.add(1);
            ownerStartBuildTime[_owner] = 0;
            return 0;
        }
        else {
            uint remainingTime = ownerStartBuildTime[_owner] + buildings[buildingID].level * buildTimeNeed - now;
            return remainingTime;
        }
    }

    function getBuildingByOwner(address _owner, uint _placeX, uint _placeY) public view returns(uint) {
        for (uint i = 0; i < buildings.length; i++) {
            if (buildingToOwner[i] == _owner) {
                if (buildings[i].placeX == _placeX && buildings[i].placeX == _placeY) {
                    return i;
                }
            }
        }
        return -1;
    }

    function getBuildingsByOwner(address _owner) public view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerFarmCount[_owner] + ownerMineCount[_owner] + ownerManorCount[_owner] + ownerQuarryCount[_owner] + ownerSawmillCount[_owner] + ownerCellarCount[_owner] + ownerBarrackCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < buildings.length; i++) {
            if (buildingToOwner[i] == _owner) {
                result[counter] = i;
                counter = counter.add(1);
            }
        }
        return result;
    }

    function getSpecificBuildingByOwner(address _owner, string memory _name) public view returns(uint[] memory) {
        uint buildingsLength;
        if (keccak256(bytes(_name)) == keccak256(bytes("Farm"))) {
           buildingsLength = ownerFarmCount[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Mine"))) {
            buildingsLength = ownerMineCount[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Manor"))) {
            buildingsLength = ownerManorCount[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Quarry"))) {
            buildingsLength = ownerQuarryCount[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Sawmill"))) {
            buildingsLength = ownerSawmillCount[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Cellar"))) {
            buildingsLength = ownerCellarCount[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Barrack"))) {
            buildingsLength = ownerBarrackCount[_owner];
        }
        uint[] memory result = new uint[](buildingsLength);
        // result.push(0);
        uint counter = 0;
        for (uint i = 0; i < buildings.length; i++) {
            if (buildingToOwner[i] == _owner && keccak256(bytes(buildings[i].name)) == keccak256(bytes(_name))) {
                result[counter] = i;
                counter = counter.add(1);
            }
        }
        return result;
    }

    
}