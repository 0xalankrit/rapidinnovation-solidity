const {ethers} = require("hardhat");

async function main() {
  const [accounts] =await ethers.getSigners();
  console.log(accounts.address); 
  
  const NFTContract = await ethers.getContractFactory("NFTContract");
  const nftcontract= await NFTContract.deploy("DOG-NFT","DOG");

  await nftcontract.deployed();
  console.log("NFTContract deployed to:", nftcontract.address);
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
