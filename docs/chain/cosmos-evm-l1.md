# Gami Chain — Cosmos EVM L1 Direction

Gami Chain is positioned long-term as a sovereign Cosmos SDK + EVM-compatible Layer 1 purpose-built for programmable rewards, XP, quests, airdrops, AI incentive systems, staking, and partner reward settlement.

## Target architecture

- Base: Cosmos SDK
- EVM module: Ethermint / Evmos-style EVM compatibility
- Consensus: CometBFT
- Native token: GAMI
- Chain ID: gami_7433-1
- EVM Chain ID: 7433
- Testnet chain ID: gami_testnet_74331-1
- Testnet EVM Chain ID: 74331

## Why Cosmos EVM L1

1. Sovereign validator set for Gami-specific reward economics.
2. EVM compatibility for wallets, Solidity contracts, and existing Web3 tooling.
3. Cosmos IBC path for future cross-chain reward interoperability.
4. Native modules can later handle XP, quests, reward weights, fee rebates, partner zones, and reputation.
5. Better long-term branding as an engagement/reward-specific Layer 1.

## MVP path

Phase 1 keeps the Solidity contract layer, wallet integration, airdrop claim system, dashboard, and RPC standards compatible with EVM tooling.

Phase 2 introduces the Cosmos node stack:

```txt
gamid/              Cosmos daemon
x/rewards/          native reward module
x/xp/               native XP module
x/quests/           native quest module
x/partners/         partner registry module
x/airdrop/          genesis claim or module-based airdrop
ethermint/          EVM runtime
cometbft/           consensus
```

## RPC endpoints

```txt
EVM RPC: https://rpc.gamiprotocol.xyz
EVM WS:  wss://rpc.gamiprotocol.xyz/ws
Cosmos RPC: https://cosmos-rpc.gamiprotocol.xyz
REST API: https://api.gamiprotocol.xyz/cosmos
gRPC: grpc.gamiprotocol.xyz:443
Explorer: https://explorer.gamiprotocol.xyz
```

## Launch recommendation

Use EVM Solidity contracts for the first TGE, airdrop, staking, and reward pool. Migrate high-frequency XP and quest accounting into native Cosmos modules after mainnet stability.
