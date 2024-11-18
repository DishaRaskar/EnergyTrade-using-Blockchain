// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract EnergyMarketplace is Ownable {
    IERC20 public energyToken;
    uint256 public pricePerUnit = 1 ether; // Price of one unit of energy in wei

    // Events to track marketplace transactions
    event EnergyBought(address indexed buyer, uint256 amount);
    event EnergySold(address indexed seller, uint256 amount);

    constructor(address _energyToken) Ownable(msg.sender) {
        energyToken = IERC20(_energyToken);
    }

    // Function to buy energy tokens by sending Ether
    function buyEnergy(uint256 amount) external payable {
        require(msg.value >= amount * pricePerUnit, "Insufficient Ether sent");
        
        uint256 balance = energyToken.balanceOf(address(this));
        require(balance >= amount, "Not enough energy available");

        // Transfer tokens to the buyer
        energyToken.transfer(msg.sender, amount);
        emit EnergyBought(msg.sender, amount);
    }

    // Function to sell energy tokens and receive Ether
    function sellEnergy(uint256 amount) external {
        require(energyToken.balanceOf(msg.sender) >= amount, "Insufficient energy tokens");

        // Transfer tokens from the seller to the contract
        energyToken.transferFrom(msg.sender, address(this), amount);

        // Transfer Ether to the seller
        payable(msg.sender).transfer(amount * pricePerUnit);
        emit EnergySold(msg.sender, amount);
    }

    // Owner-only function to update the price per unit of energy
    function setPricePerUnit(uint256 newPrice) external onlyOwner {
        pricePerUnit = newPrice;
    }

    // Withdraw Ether from the contract (only owner)
    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}

