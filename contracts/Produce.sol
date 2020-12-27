pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Quarry.sol";
import "./Mine.sol";
import "./Farm.sol";
import "./Manor.sol";
import "./Sawmill.sol";

contract Produce is Quarry, Mine, Farm, Manor, Sawmill {

    function _updateProduce(address _owner) internal {
        _updateProduceCoin(_owner);
        _updateProduceOre(_owner);
        _updateProduceFood(_owner);
        _updateProduceRock(_owner);
        _updateProduceWood(_owner);
    }

}