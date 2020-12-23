pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Account.sol";

contract BuildingFactory is Account {
    
    struct Building {
        string name;
        uint placeX;
        uint placeY;
        uint level;
    }

    uint buildTimeNeed = 1;
    Building[] public buildings;

    mapping (uint => address) public buildingToOwner;
    mapping (address => uint) ownerStartBuildTime;
    mapping (address => uint) ownerBuildingId; //the building that is building
    mapping (address => uint) castleLevel;

    function _createBuilding(string memory _name, uint _x, uint _y) internal {
        uint id = buildings.push(Building(_name, _x, _y, 1).sub(1);
        buildingToOwner[id] = msg.sender;
    }

    function _startBuild(address _owner, uint _x, uint _y) internal returns(uint){
        buildingID = _getBuildingByOwner(_owner, _x, _y);
        if (buildings[buildingID].name != "Castle") {
            require(castelLevel[_owner] >= buildings[buildingID].level.add(1));
        }
        ownerBuildingId[_owner] = buildingID;
        ownerStartBuildTime[_owner] = now;
        return buildings[buildingID].level * buildTimeNeed;
    }
    
    function _updateBuild(address _owner) internal returns(bool){
        buildingID = ownerBuildingId[_owner];
        if (ownerStartBuildTime[_owner] != 0 && now >= ownerStartBuildTime[_owner] + buildings[buildingID].level * buildTimeNeed) {
            buildings[buildingID].level = buildings[buildingID].level.add(1);
            ownerStartBuildTime[_owner] = 0;
            return true;
        }
        return false;
    }

    function _getBuildingByOwner(address _owner, uint _placeX, uint _placeY) internal view returns(uint memory) {
        for (uint i = 0; i < buildings.length; i++) {
            if (buildingToOwner[i] == _owner) {
                if (buildings[i].placeX == _placeX && buildings[i].placeX == _placeY) {
                    return i;
                }
            }
        }
    }

    function _getBuildingsByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result;
        for (uint i = 0; i < buildings.length; i++) {
            if (buildingToOwner[i] == _owner) {
                result.push(i);
            }
        }
        return result;
    }

    function _getSpecificBuildingByOwner(address _owner, string _name) internal view returns(uint[] memory) {
        uint[] memory result;
        result.push(0);
        for (uint i = 0; i < buildings.length; i++) {
            if (buildingToOwner[i] == _owner && buildings[i].name == _name) {
                result.push(i);
            }
        }
        return result;
    }
}