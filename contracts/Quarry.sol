pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract QuarryFactory is CastleFactory {
    
    mapping (address => uint) public ownerStoneProduceTime;
    uint produceStoneAbility = 1;


    function _createQuarry(uint _x, uint _y) internal {
        _createBuilding("Quarry", _x, _y);
        _updateProduceStone(msg.sender);
    }

    function _startBuildQuarry(address _owner, uint _x, uint _y) internal {
        quarryID = _getBuildingByOwner(_owner, "Quarry", _x, _y);
        require(buildings[quaryID].add(1) <= castleLevel[_owner]);
        _startBuild(quarryID);
    }
    
    function _updateProduceStone(address _owner) internal {
        quarries = _getSpecificBuildingByOwner(_owner, "Quarry");
        if (quarrries.length > 1){
            while (now > ownerStoneProduceTime[_owner].add(10 seconds)) {
                for (uint i = 1; i < quarries.length; i++) {
                    stoneOwnerCount[_owner] = stoneOwnerCount[_owner].add(buildings[quarries[i]].level * produceStoneAbility );
                }
                ownerStoneProduceTime[_owner] = ownerStoneProduceTime[_owner].add(10 seconds);
            }
        }
        else {
            ownerStoneProduceTime[_owner] = now;
        }
    }
}