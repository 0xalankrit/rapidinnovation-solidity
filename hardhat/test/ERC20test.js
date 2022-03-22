const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Bluetoken",function(){
  let owner,addr1,addr2,addrs;
  let bluetoken;
  beforeEach( async ()=>{
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
    const Bluetoken =await ethers.getContractFactory("Bluetoken");
    bluetoken =await Bluetoken.deploy("Bluetoken","BT",0,1000);
  })
  describe("Deployment", function () {

    it("Should assign the total supply of tokens to the owner", async function () {
      const ownerBalance = await bluetoken.balanceOf(owner.address);
      expect(await bluetoken.totalSupply()).to.equal(ownerBalance);
    });
    it("Should have correct name and symbol",async()=>{
        const name =await bluetoken.name();
        const symbol  =await bluetoken.symbol();
        expect(name).to.equal("Bluetoken");
        expect(symbol).to.equal("BT");
    })
    describe("Transactions", function () {
      it("Should transfer tokens between accounts", async function () {
        let ownerBalance = await bluetoken.balanceOf(owner.address);

        // Transfer 50 tokens from owner to addr1
        const result = await bluetoken.transfer(addr1.address, 50);
        let addr1Balance = await bluetoken.balanceOf(addr1.address);
        // ownerBalance = await bluetoken.balanceOf(owner.address);
        
        const receipt =await result.wait()
        
        // Listning to Transfer event
        const event =(receipt.events).filter((x) => {return x.event == "Transfer"});
        // console.log(event[0].args.from);

        expect(event[0].args.from).to.equal(owner.address);
        expect(event[0].args.to).to.equal(addr1.address);
        expect(event[0].args.amount).to.equal(50);


        // Transfer 50 tokens from addr1 to addr2
        await bluetoken.connect(addr1).transfer(addr2.address, 20);

        const addr2Balance = await bluetoken.balanceOf(addr2.address);
        addr1Balance = await bluetoken.balanceOf(addr1.address);
        ownerBalance = await bluetoken.balanceOf(owner.address);
        
        expect(addr2Balance).to.equal(20);
        // console.log(ownerBalance)
        // console.log(addr1Balance)
        // console.log(addr2Balance)
    });
    it("Should fail if sender doesn’t have enough tokens", async function () {
      const initialOwnerBalance = await bluetoken.balanceOf(owner.address);

      // Try to send 10 token from addr1 to owner .
      // Condition will fail as addr1 balance is 0 tokens .

      // console.log(initialOwnerBalance);
      await expect(
        bluetoken.connect(addr1).transfer(owner.address, 10)
      ).to.be.revertedWith("ERC20: transfer amount exceeds balance");

      // Owner balance shouldn't have changed.
      const newOwnerBalance =await bluetoken.balanceOf(owner.address);
      expect(newOwnerBalance).to.equal(initialOwnerBalance);
    });
    it("Testing transferFrom function", async () => {
        const result1 =await bluetoken.approve(addr1.address,80);
        let tx =await result1.wait();
        // console.log(tx.events.filter(x=>{return x.event ==="Approve"}));
        
        expect(tx.events[0].args.owner).to.equal(owner.address);   
        expect(tx.events[0].args.spender).to.equal(addr1.address); 
        expect(tx.events[0].args.amount).to.equal(80);              
        
        const result = await bluetoken.allowance(owner.address,addr1.address);
        expect(result).to.equal(80);
        
        addr1beforeBalance =await bluetoken.balanceOf(addr1.address);
        addr1beforeAllowance =await bluetoken.allowance(owner.address,addr1.address);
        
        await bluetoken.connect(addr1).transferFrom(owner.address,addr2.address,35);
        
        addr1afterBalance =await bluetoken.balanceOf(addr1.address);
        addr1afterAllowance =await bluetoken.allowance(owner.address,addr1.address);
        
        expect(addr1beforeBalance).to.equal(0);
        expect(addr1afterBalance).to.equal(0);
        
        expect(addr1beforeAllowance).to.equal(80);
        expect(addr1afterAllowance).to.equal(45);
      })
    })
    describe('Allowance',async ()=>{
      it("Testing increase allowance function", async ()=>{
        await bluetoken.approve(addr1.address,120);
        const allowance =await bluetoken.allowance(owner.address,addr1.address);
        expect(allowance).to.equal(120);
        await bluetoken.increaseAllowance(addr1.address,30);

        const newAllowance = await bluetoken.allowance(owner.address,addr1.address);
        expect(newAllowance).to.equal(120+30);
      })
      it("Testing increase allowance function", async ()=>{
        await bluetoken.approve(addr1.address,120);
        const allowance =await bluetoken.allowance(owner.address,addr1.address);
        expect(allowance).to.equal(120);
        await bluetoken.decreaseAllowance(addr1.address,30);

        const newAllowance = await bluetoken.allowance(owner.address,addr1.address);
        expect(newAllowance).to.equal(120-30);
      })
      it("Testing failing increase allowance function", async ()=>{
        await bluetoken.approve(addr1.address,120);
        const allowance =await bluetoken.allowance(owner.address,addr1.address);
        expect(allowance).to.equal(120);
        
        await expect(bluetoken.decreaseAllowance(addr1.address,130)).to.be.revertedWith("ERC20: decreased allowance below zero")
      })
    })
    describe("Mint and Burn ERC20 token",async function () {
      it("Testing _mint function", async () => {
        const initTotalSupply =await bluetoken.totalSupply();
        const initOwnerBalance =await bluetoken.balanceOf(owner.address);

        await bluetoken._mint(owner.address,200);

        const finalTotalSupply =await bluetoken.totalSupply();
        const finalOwnerBalance =await bluetoken.balanceOf(owner.address);
        
        expect(initTotalSupply).to.equal(1000);
        expect(initOwnerBalance).to.equal(1000);
        expect(finalTotalSupply).to.equal(1000+200);
        expect(finalOwnerBalance).to.equal(1000+200);
      })
      it("Testing _burn function", async () => {
        const initTotalSupply =await bluetoken.totalSupply();
        const initOwnerBalance =await bluetoken.balanceOf(owner.address);

        await bluetoken._burn(owner.address,200);

        const finalTotalSupply =await bluetoken.totalSupply();
        const finalOwnerBalance =await bluetoken.balanceOf(owner.address);
        
        expect(initTotalSupply).to.equal(1000);
        expect(initOwnerBalance).to.equal(1000);
        expect(finalTotalSupply).to.equal(1000-200);
        expect(finalOwnerBalance).to.equal(1000-200);
      })
      it("Testing failing _burn function", async () => {
        const initTotalSupply =await bluetoken.totalSupply();
        const initOwnerBalance =await bluetoken.balanceOf(owner.address);

        await expect(bluetoken._burn(owner.address,1200)).to.be.revertedWith("ERC20: burn amount exceeds balance");
      })
    })
  });
})