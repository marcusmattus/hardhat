// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RewardPool is Ownable {
    IERC20 public token;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function fund(uint256 amount) external {
        require(token.transferFrom(msg.sender, address(this), amount), "fund failed");
    }

    function distribute(address to, uint256 amount) external onlyOwner {
        require(token.transfer(to, amount), "transfer failed");
    }
}
