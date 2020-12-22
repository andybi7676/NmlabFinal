pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract FarmFactory is CastleFactory {
    
    mapping (address => uint) public foodOwnerCount;
    uint produceFoodAbility = 1;

    function _createFarm(uint _x, uint _y) internal {
        _createBuilding("Farm", _x, _y);
        _produceFood(msg.sender, _x, _y);
    }

    function _startBuildFarm(address _owner, uint _x, uint _y) internal {
        farmID = _getBuildingByOwner(_owner, "Farm", _x, _y);
        require(buildings[farmID].add(1) <= castleLevel[_owner]);
        _startBuild(farmID);
    }

    function _produceFood(address _owner, uint _x, uint _y) internal {
        farmID = _getBuildingByOwner(_owner, "Farm", _x, _y);
        while (now > buildings[farmID].producetime.add(1 hours)) {
            buildings[farmID].producetime = buildings[farmID].produceTime.add(1 hours);
            foodOwnerCount[_owner] = foodOwnerCount[_owner].add(buildings[mineID].level * produceFoodAbility );
        } 
    }

}