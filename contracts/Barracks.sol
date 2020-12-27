pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract BarrackFactory is CastleFactory {
    
    function _createBarrack(uint _x, uint _y) internal {
        _createBuilding("Barrack", _x, _y);
    }

    
}