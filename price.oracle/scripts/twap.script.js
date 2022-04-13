// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  
  const UniswapV2Twap = await hre.ethers.getContractFactory("UniswapV2Twap");
  const twap = await UniswapV2Twap.deploy("0x8B22F85d0c844Cf793690F6D9DFE9F11Ddb35449");

  await twap.deployed();

  console.log("Contract deployed to:", twap.address);
  const token0 = await twap.token0();
  const token1 = await twap.token1();
  // console.log(token0);
  // console.log(token1);
  // await twap.update(); 
  let wei = hre.ethers.utils.parseEther("1");
  console.log(wei);
  console.log(await twap.consult(token1,wei));
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

  // ETH/DAI Pari contract mainnet 0xa478c2975ab1ea89e8196811f51a7b7ade33eb11
  // WETH9/DAI Pair contract rinkeby 0x8B22F85d0c844Cf793690F6D9DFE9F11Ddb35449
  // DAI/LINK Pair contract rinkeby 0xc06F69a8b473910ABaC707dbA66bB9Bc4a975c0A

