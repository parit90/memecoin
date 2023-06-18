// File: v1.sol

pragma solidity ^0.8.0;

import './ERC20.sol';
import './access/Ownable.sol';

contract paCoin is ERC20, Ownable {
    uint256 private _totalSupply = 133769420 * (10 ** 18);
    uint256 private _tokenPrice = 200000 * (10 ** 18);

    constructor() ERC20("paCoin", "paCoin") {
        _mint(msg.sender, _totalSupply);
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");
        payable(msg.sender).transfer(balance);
    }

    function setTokenPrice(uint256 newTokenPrice) external onlyOwner {
        require(newTokenPrice > 0, "Token price should be greater than 0");
        _tokenPrice = newTokenPrice;
    }

    function getTokenPrice() external view returns (uint256) {
        return _tokenPrice;
    }

    function burn(uint256 amount) external {
        require(amount > 0, "Amount to burn should be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Not enough tokens to burn");
        _burn(msg.sender, amount);
    }
}