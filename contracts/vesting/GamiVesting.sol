// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GamiVesting {
    IERC20 public immutable token;

    struct Vest {
        uint256 total;
        uint256 claimed;
        uint256 start;
        uint256 duration;
    }

    mapping(address => Vest) public vests;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function addVest(address user, uint256 total, uint256 duration) external {
        vests[user] = Vest(total, 0, block.timestamp, duration);
    }

    function claim() external {
        Vest storage v = vests[msg.sender];
        require(v.total > 0, "no vest");

        uint256 elapsed = block.timestamp - v.start;
        if (elapsed > v.duration) elapsed = v.duration;

        uint256 vested = (v.total * elapsed) / v.duration;
        uint256 claimable = vested - v.claimed;

        require(claimable > 0, "nothing to claim");
        v.claimed += claimable;

        require(token.transfer(msg.sender, claimable), "transfer failed");
    }
}
