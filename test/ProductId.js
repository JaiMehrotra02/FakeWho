const Web3 = require('web3');
const abi = require('./ProductRegistry.json'); // Assuming you have your contract ABI in a separate file
const contractAddress = '0x8c1B15AF9961856847771516D876367cBCc28d44'; // Replace with your contract address
const providerUrl = 'http://127.0.0.1:7545';

// Create a new web3 instance with the given provider URL
const web3 = new Web3.providers.HttpProvider(providerUrl);

// const provider = new Web3.providers.HttpProvider('http://127.0.0.1:7545'); // Replace with your Ethereum node URL
// const web3 = new Web3(provider);

// Instantiate the contract
const productVerificationContract = new web3.eth.Contract(abi, contractAddress);

async function registerProduct(productName, manufacturingDate, manufacturer) {
    try {
        // Call the registerProduct function on the contract
        const transaction = await productVerificationContract.methods.registerProduct(productName, manufacturingDate, manufacturer).send({
            from: manufacturer, // Assuming manufacturer is the sender
            gas: 2000000 // Adjust gas limit as needed
        });
        
        // Get the transaction receipt
        const receipt = await web3.eth.getTransactionReceipt(transaction.transactionHash);
        
        // Extract the product ID from the event logs
        const events = receipt.logs.map(log => productVerificationContract._decodeEventABI.call({name: 'ProductRegistered', type: 'event'}, log));
        const productId = events[0].returnValues.productId;

        console.log("Product ID:", productId);
    } catch (error) {
        console.error("Error registering product:", error);
    }
}

// Call the registerProduct function
registerProduct("Example Product", Date.now(), "MANUFACTURER_ADDRESS"); // Replace with actual values