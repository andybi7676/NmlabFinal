pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Quarry.sol";
import "./Mine.sol";
import "./Farm.sol";
import "./Manor.sol";
import "./Sawmill.sol";

contract Produce is Quarry, Mine, Farm, Manor, Sawmill {

    mapping (address => uint) ownerProduceTime;


    function _produce(address _owner) internal {
        
    }


}