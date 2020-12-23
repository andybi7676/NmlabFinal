pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract QuarryFactory is CastleFactory {
    
    mapping (address => uint) public ownerRockProduceTime;
    uint produceRockAbility = 1;


    function _createQuarry(uint _x, uint _y) internal {
        _createBuilding("Quarry", _x, _y);
        _updateProduceRock(msg.sender);
    }

    function _startBuildQuarry(address _owner, uint _x, uint _y) internal {
        quarryID = _getBuildingByOwner(_owner, "Quarry", _x, _y);
        require(buildings[quaryID].add(1) <= castleLevel[_owner]);
        _startBuild(quarryID);
    }
    
    function _updateProduceRock(address _owner) internal {
        quarries = _getSpecificBuildingByOwner(_owner, "Quarry");
        if (quarrries.length > 1){
            while (now > ownerRockProduceTime[_owner].add(10 seconds)) {
                for (uint i = 1; i < quarries.length; i++) {
                    rockOwnerCount[_owner] = rockOwnerCount[_owner].add(buildings[quarries[i]].level * produceRockAbility );
                }
                ownerRockProduceTime[_owner] = ownerRockProduceTime[_owner].add(10 seconds);
            }
        }
        else {
            ownerRockProduceTime[_owner] = now;
        }
    }
}