# ERC-20 && ERC-721 tests structure

```
  Bluetoken
    Deployment
      ✔ Should assign the total supply of tokens to the owner
      ✔ Should have correct name and symbol
      Transactions
        ✔ Should transfer tokens between accounts (62ms)
        ✔ Should fail if sender doesn’t have enough tokens (47ms)
        ✔ Testing transferFrom function (61ms)
      Allowance
        ✔ Testing increase allowance function
        ✔ Testing increase allowance function
        ✔ Testing failing increase allowance function
      Mint and Burn ERC20 token
        ✔ Testing _mint function
        ✔ Testing _burn function
        ✔ Testing failing _burn function


  ABCNFT
    Deployment
      ✔ Should have correct name and symbol
      ✔ Owner set properly
    Mint NFT
      ✔ Mint NFT
    Token transfer
      ✔ Testing Approve and getApproved function (60ms)
      ✔ Testing setApprovalForAll and isApprovedForAll functions, listning to approvalToAll events
      ✔ Testing Transfer NFT functions
  
  17 passing (2s)


```
