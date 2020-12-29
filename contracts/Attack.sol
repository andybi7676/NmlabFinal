pragma solidity >=0.4.21 <0.7.0;

import "./Account.sol";
import "./Soldier.sol";

contract Attack is Account, Soldier, SafeMath {

    function fight(address winner, address loser) internal{
        int powerGap = int(power[loser] * 0.5);
        while (powerGap >= 0){
            if(numOfArcher[winner] > 0){
                numOfArcher[winner]--;
                powerGap -= levelOfArcher;
            }
            if(numOfCavalry[winner] > 0){
                numOfCavalry[winner]--;
                powerGap -= levelOfCavalry;
            }
            if(numOfInfantry[winner] > 0){
                numOfInfantry[winner]--;
                powerGap -= levelOfInfantry;
            }
            if(numOfPikemen[winner] > 0){
                numOfPikemen[winner]--;
                powerGap -= levelOfPikemen;
            }
        }
        numOfArcher[loser].sub(numOfArcher[loser] * 0.8);
        numOfCavalry[loser].sub(numOfCavalry[loser] * 0.8);
        numOfInfantry[loser].sub(numOfInfantry[loser] * 0.8);
        numOfPikemen[loser].sub(numOfPikemen[loser] * 0.8);

        foodOwnerCount[winner].add(foodOwnerCount[loser] * 0.8);
        woodOwnerCount[winner].add(woodOwnerCount[loser] * 0.8);
        ironOwnerCount[winner].add(ironOwnerCount[loser] * 0.8);
        stoneOwnerCount[winner].add(stoneOwnerCount[loser] * 0.8);
        coinOwnerCount[winner].add(coinOwnerCount[loser] * 0.8);
        foodOwnerCount[loser].sub(foodOwnerCount[loser] * 0.8);
        woodOwnerCount[loser].sub(woodOwnerCount[loser] * 0.8);
        ironOwnerCount[loser].sub(ironOwnerCount[loser] * 0.8);
        stoneOwnerCount[loser].sub(stoneOwnerCount[loser] * 0.8);
        coinOwnerCount[loser].sub(coinOwnerCount[loser] * 0.8);

        winner._updatePower();
        loser._updatePower();
    }

    function attack(uint myCastleID, uint attackedCastleID) internal{
        require(msg.sender == castleToOwner[myCastleID]);
        address attackedCastle = castleToOwner[attackedCastleID];

        if (power[msg.sender] > power[attackedCastle]){
            fight(msg.sender, attackedCastle);
        }
        else{
            fight(attackedCastle, msg.sender);
        }


        // event??
    }

}