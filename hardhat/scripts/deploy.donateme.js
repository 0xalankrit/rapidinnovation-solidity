const {ethers }= require('hardhat');
require("@nomiclabs/hardhat-waffle");
async function main(){
    const [account1,account2, account3] = await ethers.getSigners();
    // console.log(account1,account2,account3);
    const DonateMe =await ethers.getContractFactory("DonateMe");
    const donateme = await DonateMe.deploy();
    await donateme.deployed();

    const x =await donateme.donationReceivedSoFar();
    console.log(x);
   
    const txhash =await account2.sendTransaction({to:donateme.address,value:ethers.utils.parseEther("2.0")});
    const result =await txhash.wait();
    console.log(result.logs)
    const y =await donateme.donationReceivedSoFar();
    console.log(y)
}

main()
.then(()=>{
    process.exit(0);
}).catch((error)=>{
    console.error(error);
    process.exit(1);
})