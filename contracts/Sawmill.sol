pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract SawmillFactory is CastleFactory {
    
    mapping (address => uint) public woodOwnerCount;
    uint produceWoodAbility = 1;

    function _createSawmill(uint _x, uint _y) internal {
        _createBuilding("Sawmill", _x, _y);
        _produceWood(msg.sender, _x, _y);
    }

    function _startBuildSawmill(address _owner, uint _x, uint _y) internal {
        sawmillID = _getBuildingByOwner(_owner, "Sawmill", _x, _y);
        require(buildings[sawmillID].add(1) <= castleLevel[_owner]);
        _startBuild(sawmillID);
    }

    function _produceWood(address _owner, uint _x, uint _y) internal {
        sawmillID = _getBuildingByOwner(_owner, "Sawmill", _x, _y);
        while (now > buildings[sawmillID].producetime.add(1 hours)) {
            buildings[sawmillID].producetime = buildings[sawmillID].produceTime.add(1 hours);
            woodOwnerCount[_owner] = woodOwnerCount[_owner].add(buildings[sawmillID].level * produceWoodAbility );
        } 
    }
}