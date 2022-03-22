const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ABCNFT",function(){
    let account1, account2, account3, abcnft;
    beforeEach( async ()=>{
        [account1, account2, account3]=await ethers.getSigners();
        let ABCNFT =await ethers.getContractFactory("ABCNFT");
        abcnft = await ABCNFT.deploy();
    })
    describe("Deployment", function () {
        it("Should have correct name and symbol", async function () {
            let name =await abcnft.name();
            let symbol =await abcnft.symbol();
            expect(name).to.equal("ABCNFT");
            expect(symbol).to.equal("ABCNFT");
        });
        it("Owner set properly",async()=>{
            let owner =await abcnft.owner();
            expect(owner).to.equal(account1.address);
        })
    });
    describe("Mint NFT", async ()=>{
        let baseTokenURL="http://abcNFT";
        
        beforeEach("Set a base tokenURI",async()=>{
            await abcnft.setBaseURI(baseTokenURL);
        })
        it("Mint NFT", async ()=>{
            const result =await abcnft.mintNFT(account1.address,"47wt26y45et");
            await result.wait();
            const balance =await abcnft.balanceOf(account1.address);
            expect(balance).to.equal(1);
            const tokenID =await abcnft.tokenURI(1);
            expect(tokenID).to.equal(`http://abcNFT47wt26y45et`)
        })
    })
    describe('Token transfer',async()=>{
        it("Testing Approve and getApproved function",async()=>{
            const result =await abcnft.mintNFT(account1.address,"47wt26y45ey");
            await result.wait();
            const result1 =await abcnft.approve(account2.address,1);
            const tx =await result1.wait();
            // console.log(tx.logs[0]);
            expect(await abcnft.getApproved(1)).to.equal(account2.address);
        })
        it("Testing setApprovalForAll and isApprovedForAll functions, listning to approvalToAll events", async () => {
            const result = await abcnft.setApprovalForAll(account3.address,true);
            const tx =await result.wait();
            const event =tx.events.filter((x)=>{return x.event ==="ApprovalForAll"});
            expect(event[0].args.owner).to.equal(account1.address);
            expect(event[0].args.operator).to.equal(account3.address);
            expect(event[0].args.approved).to.be.equal(true);

            expect(await abcnft.isApprovedForAll(account1.address,account3.address)).to.equal(true);
            
        })
        it("Testing Transfer NFT functions",async function(){
            const result =await abcnft.mintNFT(account1.address,"47wt26y45ez");
            await result.wait();
            await abcnft.transferFrom(account1.address,account3.address,1);
            expect(await abcnft.ownerOf(1)).to.equal(account3.address);
            
            // await abcnft.safeTransferFrom(account1.address,account2.address,1);
            // expect(await abcnft.ownerOf(1)).to.equal(account2.address);

        })
    })
})