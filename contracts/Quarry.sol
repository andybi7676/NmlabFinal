pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract QuarryFactory is CastleFactory {
    
    using SafeMath for uint;
    
    mapping (address => uint) public ownerStoneProduceTime;
    uint produceStoneAbility = 1;


    function _createQuarry(uint _x, uint _y) internal {
        createBuilding("Quarry", _x, _y);
        _updateProduceStone(msg.sender);
    }

    
    function _updateProduceStone(address _owner) internal {
        uint[] memory quarries = getSpecificBuildingByOwner(_owner, "Quarry");
        if (quarries.length > 1){
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