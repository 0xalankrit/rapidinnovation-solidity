// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const {ethers}= require("hardhat");

async function main() {

  const [tokenAowner, tokenBowner] =await ethers.getSigners();

  const TokenA = await ethers.getContractFactory("TokenA");
  const tokenA = await TokenA.deploy();
  await tokenA.deployed();

  const TokenB = await ethers.getContractFactory("TokenB");
  const tokenB = await TokenB.deploy();
  await tokenB.deployed();

  const UniswapV2ERC20 = await ethers.getContractFactory("UniswapV2ERC20");
  const uniswapV2ERC20 = await UniswapV2ERC20.deploy();
  await uniswapV2ERC20.deployed();

  const UniswapV2Factory = await ethers.getContractFactory("UniswapV2Factory");
  const uniswapV2Factory = await UniswapV2Factory.deploy();
  await uniswapV2Factory.deployed();

  // const UniswapV2Pair = await ethers.getContractFactory("UniswapV2Pair");
  // const uniswapV2Pair = await UniswapV2Pair.deploy();
  // await uniswapV2Pair.deployed();
  
  console.log("TokenA deployed to:", tokenA.address);
  console.log("TokenB deployed to:", tokenB.address);
  console.log("UniswapV2ERC20 deployed to:", uniswapV2ERC20.address);
  console.log("UniswapV2Factory deployed to:", uniswapV2Factory.address);
  // console.log("UniswapV2Pair deployed to:", uniswapV2Pair.address);

  const decimals = await tokenA.decimals();
  await tokenA.mint(tokenAowner.address,1000*(10**decimals));
  await tokenB.connect(tokenBowner).mint(tokenBowner.address,1000*(10**decimals));

  console.log((await tokenB.totalSupply()))
  console.log((await tokenA.totalSupply()))


  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
