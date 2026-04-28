import { useEffect, useState } from 'react';
import { ethers } from 'ethers';

export default function Airdrop() {
  const [address, setAddress] = useState("");
  const [claim, setClaim] = useState<any>(null);

  async function connectWallet() {
    const provider = new ethers.BrowserProvider((window as any).ethereum);
    const signer = await provider.getSigner();
    const addr = await signer.getAddress();
    setAddress(addr);

    const res = await fetch(`/api/airdrop-proof?address=${addr}`);
    const data = await res.json();
    setClaim(data);
  }

  async function claimAirdrop() {
    const provider = new ethers.BrowserProvider((window as any).ethereum);
    const signer = await provider.getSigner();

    const contract = new ethers.Contract(
      process.env.NEXT_PUBLIC_AIRDROP_CONTRACT!,
      [
        "function claim(uint256 amount, bytes32[] calldata proof)"
      ],
      signer
    );

    await contract.claim(claim.amount, claim.proof);
  }

  return (
    <div style={{ padding: 40 }}>
      <h1>Gami Airdrop</h1>
      {!address && <button onClick={connectWallet}>Connect Wallet</button>}

      {address && claim && (
        <div>
          <p>Address: {address}</p>
          <p>Claimable: {claim.amount}</p>
          <button onClick={claimAirdrop}>Claim</button>
        </div>
      )}
    </div>
  );
}
