// SPDX-License-Identifier: MIT
// pragma solidity >=0.4.22 <0.9.0;

// contract ProductRegistry {
//     struct Product {
//         // uint256 id;
//         // string name;
//         // uint256 price;
//         string productName;
        
//         uint256 manufacturingDate;
//         address manufacturer;
//         bool isRegistered;
//     }

// //     mapping(uint256 => Product) public products;
// //     uint256 public productCount;

// //     event ProductRegistered(uint256 indexed id, string name, uint256 price);

// //     function registerProduct(string memory _name, uint256 _price) public {
// //         productCount++;
// //         products[productCount] = Product(productCount, _name, _price);
// //         emit ProductRegistered(productCount, _name, _price);
        
// //     }
    
// //     function getProductDetails(uint256 _productId) public view returns (uint256, string memory, uint256) {
// //         require(_productId > 0 && _productId <= productCount, "Invalid product ID");
// //         Product memory product = products[_productId];
// //         return (product.id, product.name, product.price);
// //     }
// // }

//     mapping (bytes32 => Product) public products;
//     bytes32 public productIds;
//     // Event to log product registration on blockchain/UI/Other contracts
//     event ProductRegistered(bytes32 productId,string productName, uint256 manufacturingDate, address manufacturer);

//     // Modifier jo ensure karega ki keval manufacturer can perform certain actions
//     modifier onlyManufacturer(bytes32 productId) {
//         require(products[productId].manufacturer == msg.sender, "Only manufacturer can perform this action");
//         _;
//     }

//     // Product ko register karne ke liye
//     function registerProduct(string memory productName , uint256 manufacturingDate, address manufacturer) public returns (bytes32){
//         //to store the product details
//         string memory productdetails = string(abi.encodePacked(productName, manufacturingDate, manufacturer));
//         //hash me product id bana liya  given product details se
//         bytes32 productId = keccak256(abi.encodePacked(productdetails));
//          //check if product is already registered
//         require (!products[productId].isRegistered, "Product already registered");
//         // Store product details
//         products[productId] = Product(productName, manufacturingDate, msg.sender, true);
//         //event emit karega ui/frontend par
//         emit ProductRegistered(productId, productName, manufacturingDate, msg.sender);

//         return productId;
//     }

//     // Function to verify the authenticity of a product
//     function verifyProduct(bytes32 productId) public view returns (bool) {
//         return products[productId].isRegistered;
//     }

//     // Function product details ke liye
//     function getProductDetails(bytes32 productId) public view returns (string memory name, uint256 manufacturingDate, address manufacturer, bool isRegistered) {
//         Product memory product = products[productId];
//         return (product.productName, product.manufacturingDate, product.manufacturer, product.isRegistered);
//     }

//     // Function to update product details (keval manufacturer access kar sakta hai)
//     function updateProductDetails(bytes32 productId, string memory newName, uint256 newManufacturingDate) public onlyManufacturer(productId) {
//         Product storage product = products[productId];
//         product.productName = newName;
//         product.manufacturingDate = newManufacturingDate;
//     }
// }

pragma solidity ^0.8.0;

// Struct jo represent kr rha product details
 struct Product {
        string productName;
        uint256 manufacturingDate;
        address manufacturer;
        bool isRegistered;
    }

contract ProductRegistry {
    //products nam ka map ds bana liya to store product details by product ID
    mapping (bytes32 => Product) products;

    // Event to log product registration on blockchain/UI/Other contracts
    event ProductRegistered(bytes32 productId,string productName, uint256 manufacturingDate, address manufacturer);

    // Modifier jo ensure karega ki keval manufacturer can perform certain actions
    modifier onlyManufacturer(bytes32 productId) {
        require(products[productId].manufacturer == msg.sender, "Only manufacturer can perform this action");
        _;
    }

    // Product ko register karne ke liye
    function registerProduct(string memory productName , uint256 manufacturingDate, address manufacturer) public returns (bytes32){
        //to store the product details
        string memory productdetails = string(abi.encodePacked(productName, manufacturingDate, manufacturer));
        //hash me product id bana liya  given product details se
        bytes32 productId = keccak256(abi.encodePacked(productdetails));
         //check if product is already registered
        require(!products[productId].isRegistered, "Product already registered");
        // Store product details
        products[productId] = Product(productName, manufacturingDate, msg.sender, true);
        //event emit karega ui/frontend par
        emit ProductRegistered(productId, productName, manufacturingDate, msg.sender);

        return productId;
    }

    // Function to verify the authenticity of a product
    function verifyProduct(bytes32 productId) public view returns (bool) {
        return products[productId].isRegistered;
    }

    // Function product details ke liye
    function getProductDetails(bytes32 productId) public view returns (string memory name, uint256 manufacturingDate, address manufacturer, bool isRegistered) {
        Product memory product = products[productId];
        return (product.productName, product.manufacturingDate, product.manufacturer, product.isRegistered);
    }

    // Function to update product details (keval manufacturer access kar sakta hai)
    function updateProductDetails(bytes32 productId, string memory newName, uint256 newManufacturingDate) public onlyManufacturer(productId) {
        Product storage product = products[productId];
        product.productName = newName;
        product.manufacturingDate = newManufacturingDate;
    }
}











/*ye smart contract have ye sari bate:

Product Registration-- Manufacturers can register their products by providing the product ID, name, and manufacturing date.
Product Verification--- Consumers can verify the authenticity of a product by querying the blockchain with its product ID.
Product Details--- Manufacturers can retrieve product details and update them if necessary.
Events-- Events are emitted for product registration to provide transparency.


we will integrate this smart contract with a QR code generation library in hamare DApp to generate QR codes containing the product ID for easy verification. Aur fir fronend flutter for mobile and mern for webd,,, we'll need to develop a front-end interface using Flutter to interact with the smart contract aur handle QR code scanning */