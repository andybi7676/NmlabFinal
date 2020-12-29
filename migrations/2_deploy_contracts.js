// var SimpleStorage = artifacts.require("./SimpleStorage.sol");

// module.exports = function(deployer) {
//   deployer.deploy(SimpleStorage);
// };

var BuildingFactory = artifacts.require("./BuildingFactory.sol")

module.exports = function(deployer) {
  deployer.deploy(BuildingFactory);
};