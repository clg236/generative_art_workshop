// A Web3Provider wraps a standard Web3 provider, which is
// what Metamask injects as window.ethereum into each page
const provider = new ethers.providers.Web3Provider(window.ethereum)

// The Metamask plugin also allows signing transactions to
// send ether and pay to change state within the blockchain.
// For this, you need the account signer...
const signer = provider.getSigner()

const address = "0x3A4F1818997A126D9e0bBC4C7728c89BB2780bF9"

const abi = [
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "random",
				"type": "uint256"
			}
		],
		"name": "createSVG",
		"outputs": [
			{
				"internalType": "string",
				"name": "svg",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "rand",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_seed",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]

// The Contract object
const contract = new ethers.Contract(address, abi, provider);
console.log(contract);

// just a test function
async function test() {
  let random = await contract.rand()
  return random
}

// we're running the test function, waiting for it to return and then console logging the huuuuuuge number. This is our "random number"
test().then(data => {
    console.log(ethers.utils.formatEther(data));
});

// create an svg from our createSVG function (passing an external int)
async function create() {
  let random = 999;
  let svg = await contract.createSVG(random);
  return svg
}

create().then(data => {
    console.log(data);
    art.innerHTML = data
});


