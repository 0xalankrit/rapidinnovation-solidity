// SPDX-License-Identifier: MIT
pragma solidity =0.5.16;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenB is ERC20, Ownable {
    constructor() ERC20("TokenB", "B") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
