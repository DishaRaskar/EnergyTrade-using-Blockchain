import { ethers } from "ethers";

async function connectToMetaMask() {
  if (typeof window.ethereum !== "undefined") {
    try {
      // Request account access if needed
      await window.ethereum.request({ method: "eth_requestAccounts" });

      // Initialize ethers provider with MetaMask's provider
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      // Get the user's address
      const userAddress = await signer.getAddress();
      console.log("Connected to MetaMask with address:", userAddress);

      return { provider, signer, userAddress };
    } catch (error) {
      console.error("Error connecting to MetaMask:", error);
    }
  } else {
    console.log("MetaMask is not installed. Please install MetaMask and try again.");
  }
}

// Usage example:
connectToMetaMask().then(({ provider, signer, userAddress }) => {
  if (userAddress) {
    // Proceed with your DApp logic here
  }
});