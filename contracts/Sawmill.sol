pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract SawmillFactory is CastleFactory {
    
    mapping (address => uint) public ownerWoodProduceTime;
    uint produceWoodAbility = 1;

    function _createSawmill(uint _x, uint _y) internal {
        _createBuilding("Sawmill", _x, _y);
        _updateProduceWood(msg.sender);
    }

    function _startBuildSawmill(address _owner, uint _x, uint _y) internal {
        sawmillID = _getBuildingByOwner(_owner, "Sawmill", _x, _y);
        require(buildings[sawmillID].add(1) <= castleLevel[_owner]);
        _startBuild(sawmillID);
    }

    function _updateProduceWood(address _owner) internal {
        sawmills = _getSpecificBuildingByOwner(_owner, "Sawmill");
        if (sawmills.length > 1){
            while (now > ownerWoodProduceTime[_owner].add(10 seconds)) {
                for (uint i = 1; i < sawmills.length; i++) {
                    woodOwnerCount[_owner] = woodOwnerCount[_owner].add(buildings[sawmills[i]].level * produceWoodAbility );
                }
                ownerWoodProduceTime[_owner] = ownerWoodProduceTime[_owner].add(10 seconds);
            }
        }
        else {
            ownerWoodProduceTime[_owner] = now;
        }
    }
}