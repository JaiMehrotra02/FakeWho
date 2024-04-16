// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ProductRegistry {
    struct Product {
        uint256 id;
        string name;
        uint256 price;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount;

    event ProductRegistered(uint256 indexed id, string name, uint256 price);

    function registerProduct(string memory _name, uint256 _price) public {
        productCount++;
        products[productCount] = Product(productCount, _name, _price);
        emit ProductRegistered(productCount, _name, _price);
        
    }
    
    function getProductDetails(uint256 _productId) public view returns (uint256, string memory, uint256) {
        require(_productId > 0 && _productId <= productCount, "Invalid product ID");
        Product memory product = products[_productId];
        return (product.id, product.name, product.price);
    }
}