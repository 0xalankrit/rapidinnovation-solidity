// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  
  const UniswapV2Reserve = await hre.ethers.getContractFactory("UniswapV2Reserve");
  const uniswapV2Reserve = await UniswapV2Reserve.deploy();

  await uniswapV2Reserve.deployed();

  console.log("Contract deployed to:", uniswapV2Reserve.address);

  const tx =await uniswapV2Reserve.setfactory("0x5c69bee701ef814a2b6a3edd4b1652cb9cc5aa6f");
  await tx.wait();

  const token ="0x514910771af9ca656af840dff83e8264ecf986ca";
  const tx2 =await uniswapV2Reserve.getPrice(token);
  const result =await tx2.wait();

  console.log(hre.ethers.utils.formatEther(result.events[0].args.price));
  
  const token0 = await uniswapV2Reserve.token0();
  const token1 = await uniswapV2Reserve.token1();

  console.log("TOKEN 0 : ",token0); // DAI
  console.log("TOKEN 1 : ",token1); // ETH
  
  console.log(await uniswapV2Reserve.getDecimal(token0));
  console.log(await uniswapV2Reserve.getDecimal(token1));

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

  // ETH/DAI Pair contract mainnet 0xa478c2975ab1ea89e8196811f51a7b7ade33eb11
  // ETH/USDC Pair contract mainnet 0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc
  // DAI/USDC Pair contract mainnet 0xAE461cA67B15dc8dc81CE7615e0320dA1A9aB8D5
  // ETH/USDT Pair contract mainnet 0x0d4a11d5EEaaC28EC3F61d100daF4d40471f1852

  // ETH token mainnet 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
  // USDC token mainnet 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
  // USDT token mainnet 0xdac17f958d2ee523a2206206994597c13d831ec7
  // LINK token mainnet 0x514910771af9ca656af840dff83e8264ecf986ca
  // BNB token mainnet 0xB8c77482e45F1F44dE1745F52C74426C631bDD52

  // DAI contract mainnet 0x6b175474e89094c44da98b954eedeac495271d0f

  // Uniswap v2 factory 0x5c69bee701ef814a2b6a3edd4b1652cb9cc5aa6f
  // Pancakeswap factory 0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73

  // CAKE contract bsc 0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82
  // BUSD contract bsc 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56

  // WETH9/DAI Pair contract rinkeby 0x8B22F85d0c844Cf793690F6D9DFE9F11Ddb35449
  // DAI/LINK Pair contract rinkeby 0xc06F69a8b473910ABaC707dbA66bB9Bc4a975c0A

