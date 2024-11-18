// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EnergyToken is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("EnergyToken", "ENG") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply * (10 ** decimals())); // Mint initial supply to contract owner
    }

    // Function to mint new tokens, accessible only by the owner
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
