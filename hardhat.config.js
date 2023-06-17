require("@nomicfoundation/hardhat-toolbox");
require("@tableland/hardhat");
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  localTableland: {
    silent: false,
    verbose: false,
  },

  networks: {
    "filecoin-calibration": {
      url: "https://api.calibration.node.glif.io/rpc/v1",
      accounts: [process.env.PRIVATEKEY],
    }
  },
};
