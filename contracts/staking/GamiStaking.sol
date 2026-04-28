// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract GamiStaking is Ownable, ReentrancyGuard {
    IERC20 public immutable gami;

    struct StakeInfo {
        uint256 amount;
        uint256 since;
        uint256 rewardDebt;
    }

    mapping(address => StakeInfo) public stakes;

    uint256 public rewardRatePerSecond = 3170979198; // approx 10% APR per 1e18 staked
    uint256 public totalStaked;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event RewardClaimed(address indexed user, uint256 amount);

    constructor(address _gami) Ownable(msg.sender) {
        gami = IERC20(_gami);
    }

    function pendingReward(address user) public view returns (uint256) {
        StakeInfo memory s = stakes[user];
        if (s.amount == 0) return 0;
        uint256 elapsed = block.timestamp - s.since;
        return (s.amount * rewardRatePerSecond * elapsed) / 1e18;
    }

    function stake(uint256 amount) external nonReentrant {
        require(amount > 0, "amount=0");
        _claim(msg.sender);
        require(gami.transferFrom(msg.sender, address(this), amount), "transfer failed");
        stakes[msg.sender].amount += amount;
        stakes[msg.sender].since = block.timestamp;
        totalStaked += amount;
        emit Staked(msg.sender, amount);
    }

    function unstake(uint256 amount) external nonReentrant {
        require(amount > 0, "amount=0");
        StakeInfo storage s = stakes[msg.sender];
        require(s.amount >= amount, "insufficient stake");
        _claim(msg.sender);
        s.amount -= amount;
        s.since = block.timestamp;
        totalStaked -= amount;
        require(gami.transfer(msg.sender, amount), "transfer failed");
        emit Unstaked(msg.sender, amount);
    }

    function claim() external nonReentrant {
        _claim(msg.sender);
    }

    function _claim(address user) internal {
        uint256 reward = pendingReward(user);
        stakes[user].since = block.timestamp;
        if (reward > 0) {
            require(gami.transfer(user, reward), "reward transfer failed");
            emit RewardClaimed(user, reward);
        }
    }

    function setRewardRate(uint256 newRate) external onlyOwner {
        rewardRatePerSecond = newRate;
    }
}
