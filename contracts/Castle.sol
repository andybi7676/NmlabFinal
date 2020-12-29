pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./BuildingFactory.sol";

contract CastleFactory is BuildingFactory {

    using SafeMath for uint;
    
    function _createCastle(uint _x, uint _y) internal {
        _createBuilding("Castle", _x, _y);
        castleLevel[msg.sender] = 1;
    }


    modifier lessThanCastle(address _owner, uint _buildingID) {
        require(buildings[_buildingID].level.add(1) <= castleLevel[_owner]);
        _;
    }
}