pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract FarmFactory is CastleFactory {
    
    using SafeMath for uint;
    
    mapping (address => uint) public ownerFoodProduceTime;
    uint produceFoodAbility = 1;

    function _createFarm(uint _x, uint _y) internal {
        createBuilding("Farm", _x, _y);
        _updateProduceFood(msg.sender);
    }


    function _updateProduceFood(address _owner) internal {
        uint[] memory farms = getSpecificBuildingByOwner(_owner, "Farm");
        if (farms.length > 0){
            while (now > ownerFoodProduceTime[_owner].add(10 seconds)) {
                for (uint i = 0; i < farms.length; i++) {
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