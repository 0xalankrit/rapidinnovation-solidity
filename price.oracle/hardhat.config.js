require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  // defaultNetwork:"localhost",
  networks:{
    // localhost:{
    //   url:"http://127.0.0.1:8545",
    // },
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/08d0a9d1045146dc888e62677f83e772`,
      accounts: ["dc32242523cf610bf7c16b778a5629337e4a213cec81b837e05a2a34bd73e5b9"]
    },
    hardhat: {
      forking: {
        url: "https://speedy-nodes-nyc.moralis.io/3b50a8f528f7397fd9f310cf/eth/mainnet",
      },
    },
  },
  solidity: "0.6.6",
};

// npx hardhat node --fork https://speedy-nodes-nyc.moralis.io/3b50a8f528f7397fd9f310cf/eth/mainnet
// npx hardhat node --fork https://speedy-nodes-nyc.moralis.io/3b50a8f528f7397fd9f310cf/bsc/mainnet

// npx hardhat run scripts/twap.script.js --network rinkeby