const Migrations = artifacts.require("Migrations");
const InJikNFTs = artifacts.require("InJikToken")

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(InJikNFTs);
};
