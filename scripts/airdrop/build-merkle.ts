import { MerkleTree } from 'merkletreejs';
import keccak256 from 'keccak256';
import fs from 'fs';

const users = [
  { address: "0x123...", amount: "1000" },
  { address: "0x456...", amount: "500" }
];

const leaves = users.map(x =>
  keccak256(x.address + x.amount)
);

const tree = new MerkleTree(leaves, keccak256, { sortPairs: true });

const root = tree.getHexRoot();

console.log("Merkle Root:", root);

const claims = users.reduce((acc, user, idx) => {
  const proof = tree.getHexProof(leaves[idx]);
  acc[user.address] = {
    amount: user.amount,
    proof
  };
  return acc;
}, {} as any);

fs.writeFileSync("./scripts/airdrop/claims.json", JSON.stringify(claims, null, 2));
