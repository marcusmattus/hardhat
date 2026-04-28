# Gami Protocol EVM Layer

Gami Protocol is being structured as an EVM-compatible rewards and gamification execution layer for XP, quests, airdrops, staking, partner incentives, and AI-powered reward orchestration.

## Target launch plan

- Testnet target: 2026-05-31
- Airdrop Season 1 target: 2026-06-20
- Audit freeze target: 2026-08-01
- Final airdrop list target: 2026-09-20
- Target $GAMI TGE: 2026-09-30

## Chain IDs

| Network | Chain ID | Symbol | RPC |
|---|---:|---|---|
| Gami Chain Testnet | 74331 | tGAMI | https://rpc-testnet.gamiprotocol.xyz |
| Gami Chain Mainnet | 7433 | GAMI | https://rpc.gamiprotocol.xyz |

## Structure

```txt
apps/                 App frontends: dashboard, wallet, explorer, ICO site
packages/             SDKs, UI, config, chain registry
contracts/            Token, airdrop, staking, rewards, governance contracts
chain/                Genesis, validators, RPC, explorer, bridge config
services/             XP engine, quest engine, ledger, airdrop, MCP, AI agents
infra/                Cloudflare, AWS, GCP, Kubernetes, Terraform, Helm
docs/                 TGE, tokenomics, architecture, API, airdrop docs
```

## Immediate priorities

1. Finalize chain registry and wallet integration.
2. Build token, vesting, staking, airdrop, and reward pool contracts.
3. Deploy testnet RPC and explorer.
4. Launch wallet + questing testnet campaign.
5. Complete airdrop scoring and sybil filtering.
6. Freeze contracts for audit before TGE.
