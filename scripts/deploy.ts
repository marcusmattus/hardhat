import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying with:", deployer.address);

  const Token = await ethers.getContractFactory("GamiToken");
  const token = await Token.deploy();
  await token.waitForDeployment();

  console.log("GamiToken:", await token.getAddress());

  const Staking = await ethers.getContractFactory("GamiStaking");
  const staking = await Staking.deploy(await token.getAddress());
  await staking.waitForDeployment();

  console.log("Staking:", await staking.getAddress());

  const RewardPool = await ethers.getContractFactory("RewardPool");
  const pool = await RewardPool.deploy(await token.getAddress());
  await pool.waitForDeployment();

  console.log("RewardPool:", await pool.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
