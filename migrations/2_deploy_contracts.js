const ProductRegistry = artifacts.require("ProductRegistry");

module.exports = function(deployer) {
  // Deploy MyContract
  deployer.deploy(ProductRegistry, /* constructor arguments if any */);
};
