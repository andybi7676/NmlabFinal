pragma solidity >=0.4.21 <0.7.0;

import "./ownable.sol";
import "./SafeMath.sol";
import "./BuildingFactory.sol";

contract Earning is Ownable, BuildingFactory {
    
    uint speedUpFee = 0.002 ether;
    uint resourceFee = 0.001 ether;
    uint getResource = 100;

    function withdraw() external onlyOwner {
        address payable _owner = address(uint160(owner()));
        _owner.transfer(address(this).balance);
    }

    function setSpeedUpFee(uint _fee) external onlyOwner {
        speedUpFee = _fee;
    }

    function speedupBuilding() external payable returns(uint){
        address _owner = msg.sender;
        require(msg.value == speedUpFee);
        ownerStartBuildTime[_owner] = ownerStartBuildTime[_owner] + buildings[buildingID].level * buildTimeNeed * 0.5;
        return _updateBuild(_owner);
    }

    function setResourceFee(uint _fee) external onlyOwner {
        resourceFee = _fee;
    }

    function getResource(string _name) external payable {
        address _owner = msg.sender;
        require(msg.value == resourceFee);
        if ( _name == "Rock") {
            rockOwnerCount[_owner] = rockOwnerCount[_owner].add(getResource);
        }
        else if (_name == "Ore") {
            oreOwnerCount[_owner] = oreOwnerCount[_owner].add(getResource);
        }
        else if (_name == "Food") {
            foodOwnerCount[_owner] = foodOwnerCount[_owner].add(getResource);
        }
        else if (_name == "Coin") {
            coinOwnerCount[_owner] = coinOwnerCount[_owner].add(getResource);
        }
        else if (_name == "Wood") {
            woodOwnerCount[_owner] = woodOwnerCount[_owner].add(getResource);
        }
    }
}