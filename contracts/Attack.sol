pragma solidity >=0.4.21 <0.7.0;

import "./Account.sol";
import "./Soldier.sol";
import "./SafeMath.sol";

contract Attack is Account, Soldier {

    function _fight(address winner, address loser) internal{
        int powerGap = int(power[loser]/2);
        while (powerGap >= 0){
            if(numOfArcher[winner] > 0){
                numOfArcher[winner]--;
                powerGap -= levelOfArcher[winner];
            }
            if(numOfCavalry[winner] > 0){
                numOfCavalry[winner]--;
                powerGap -= levelOfCavalry[winner];
            }
            if(numOfInfantry[winner] > 0){
                numOfInfantry[winner]--;
                powerGap -= levelOfInfantry[winner];
            }
            if(numOfPikemen[winner] > 0){
                numOfPikemen[winner]--;
                powerGap -= levelOfPikemen[winner];
            }
        }
        numOfArcher[loser].sub(numOfArcher[loser] * 4/5);
        numOfCavalry[loser].sub(numOfCavalry[loser] * 4/5);
        numOfInfantry[loser].sub(numOfInfantry[loser] * 4/5);
        numOfPikemen[loser].sub(numOfPikemen[loser] * 4/5);

        foodOwnerCount[winner].add(foodOwnerCount[loser] * 4/5);
        woodOwnerCount[winner].add(woodOwnerCount[loser] * 4/5);
        ironOwnerCount[winner].add(ironOwnerCount[loser] * 4/5);
        stoneOwnerCount[winner].add(stoneOwnerCount[loser] * 4/5);
        coinOwnerCount[winner].add(coinOwnerCount[loser] * 4/5);
        foodOwnerCount[loser].sub(foodOwnerCount[loser] * 4/5);
        woodOwnerCount[loser].sub(woodOwnerCount[loser] * 4/5);
        ironOwnerCount[loser].sub(ironOwnerCount[loser] * 4/5);
        stoneOwnerCount[loser].sub(stoneOwnerCount[loser] * 4/5);
        coinOwnerCount[loser].sub(coinOwnerCount[loser] * 4/5);

        _updatePower(winner);
        _updatePower(loser);
    }

    function attack(uint _ownerId, uint _attackedCastleId) internal{
        require(msg.sender == castleToOwner[_ownerId]);
        address myCastle = castleToOwner[_ownerId];
        address attackedCastle = castleToOwner[_attackedCastleId];

        if (power[myCastle] > power[attackedCastle]){
            _fight(myCastle, attackedCastle);
        }
        else{
            _fight(attackedCastle, myCastle);
        }
    }

}