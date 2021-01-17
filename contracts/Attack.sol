pragma solidity >=0.4.21 <0.7.0;

import "./Account.sol";
import "./Soldier.sol";
import "./SafeMath.sol";

contract Attack is Account, Soldier {
    using SafeMath for uint;
    using SafeMath for uint;
    using SafeMath for uint;


    function _fight(address myCastle, address attackedCastle) internal{
        address winner;
        address loser;

        if (power[myCastle] > power[attackedCastle]){
            winner = myCastle;
            loser = attackedCastle;

        }
        else {
            winner = attackedCastle;
            loser = myCastle;
        }
        
        foodOwnerCount[winner] = foodOwnerCount[winner].add(foodOwnerCount[loser] * 4/5);
        woodOwnerCount[winner] = woodOwnerCount[winner].add(woodOwnerCount[loser] * 4/5);
        ironOwnerCount[winner] = ironOwnerCount[winner].add(ironOwnerCount[loser] * 4/5);
        stoneOwnerCount[winner] = stoneOwnerCount[winner].add(stoneOwnerCount[loser] * 4/5);
        coinOwnerCount[winner] = coinOwnerCount[winner].add(coinOwnerCount[loser] * 4/5);
        foodOwnerCount[loser] = foodOwnerCount[loser].sub(foodOwnerCount[loser] * 4/5);
        woodOwnerCount[loser] = woodOwnerCount[loser].sub(woodOwnerCount[loser] * 4/5);
        ironOwnerCount[loser] = ironOwnerCount[loser].sub(ironOwnerCount[loser] * 4/5);
        stoneOwnerCount[loser] = stoneOwnerCount[loser].sub(stoneOwnerCount[loser] * 4/5);
        coinOwnerCount[loser] = coinOwnerCount[loser].sub(coinOwnerCount[loser] * 4/5);

        uint winnerPowerLose = power[loser] / 2;

        numOfSoldier[winner] = (power[winner] - winnerPowerLose) / levelOfSoldier[winner];

        numOfSoldier[loser] = numOfSoldier[loser] * 4 / 5;

        _updatePower(winner);
        _updatePower(loser);
    }

    function attack(uint _ownerId, uint _attackedCastleId) public {
        require(msg.sender == castleToOwner[_ownerId]);
        address myCastle = castleToOwner[_ownerId];
        address attackedCastle = castleToOwner[_attackedCastleId];
        _fight(myCastle, attackedCastle);
    }

}