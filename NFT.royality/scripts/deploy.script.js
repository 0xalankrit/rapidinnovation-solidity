const { ethers } = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const [account1, account2] = await ethers.getSigners();
  console.log(account1.address);
  console.log(account2.address);

  const NFT = await ethers.getContractFactory("NFTC");
  const nft = await NFT.deploy();
  await nft.deployed();

  console.log("NFT deployed to:", nft.address);
  console.log()
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
