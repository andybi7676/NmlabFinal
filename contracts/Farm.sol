pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract FarmFactory is CastleFactory {
    
    mapping (address => uint) public ownerFoodProduceTime;
    uint produceFoodAbility = 1;

    function _createFarm(uint _x, uint _y) internal {
        _createBuilding("Farm", _x, _y);
        _updateProduceFood(msg.sender);
    }

    function _startBuildFarm(address _owner, uint _x, uint _y) internal {
        farmID = _getBuildingByOwner(_owner, "Farm", _x, _y);
        require(buildings[farmID].add(1) <= castleLevel[_owner]);
        _startBuild(farmID);
    }

    function _updateProduceFood(address _owner) internal {
        farms = _getSpecificBuildingByOwner(_owner, "Farm");
        if (farms.length > 1){
            while (now > ownerFoodProduceTime[_owner].add(10 seconds)) {
                for (uint i = 1; i < mines.length; i++) {
                    foodOwnerCount[_owner] = foodOwnerCount[_owner].add(buildings[farms[i]].level * produceFoodAbility );
                }
                ownerFoodProduceTime[_owner] = ownerFoodProduceTime[_owner].add(10 seconds);
            }
        }
        else {
            ownerFoodProduceTime[_owner] = now;
        }
    }

}