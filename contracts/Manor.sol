pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract ManorFactory is CastleFactory {
    
    using SafeMath for uint;
    
    mapping (address => uint) public ownerCoinProduceTime;
    uint produceCoinAbility = 1;

    function _createManor(uint _x, uint _y) internal {
        createBuilding("Manor", _x, _y);
        _updateProduceCoin(msg.sender);
    }


    function _updateProduceCoin(address _owner) internal {
        uint[] memory manors = getSpecificBuildingByOwner(_owner, "Manor");
        if (manors.length > 0){
            while (now > ownerCoinProduceTime[_owner].add(10 seconds)) {
                for (uint i = 0; i < manors.length; i++) {
                    coinOwnerCount[_owner] = coinOwnerCount[_owner].add(buildings[manors[i]].level * produceCoinAbility );
                }
                ownerCoinProduceTime[_owner] = ownerCoinProduceTime[_owner].add(10 seconds);
            }
        }
        else {
            ownerCoinProduceTime[_owner] = now;
        }
    }
}