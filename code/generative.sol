pragma solidity ^0.8.0;

contract Generate {
    
    string internal constant SVG_HEADER = '<svg xmlns="http://www.w3.org/2000/svg" version="1.2">';
    string internal constant SVG_FOOTER = '</svg>';
    
    // if we really wanted some 'randomness, can use keccak256'
    function rand() public view returns(uint256 _seed) {
        uint256 _seed = uint256(keccak256(abi.encodePacked(block.timestamp)));
        return _seed;
    }
    
    function createSVG(uint256 random) external view returns (string memory svg) {
        svg = string(abi.encodePacked(SVG_HEADER));
        svg = string(abi.encodePacked(svg,
        '<filter id="a"><feTurbulence baseFrequency=".005" seed="', toString(random), '"/></filter><rect width="100%" height="100%" filter="url(#a)"/>'));
        svg = string(abi.encodePacked(svg, SVG_FOOTER));
    }
    
    // this is a function that will let us convert our random int into a string
    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
