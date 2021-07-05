pragma solidity >=0.8.0 <0.9.0;

// Using Solidity 0.8 for integrated SafeMath

// Approach 
// The idea is to save gas by avoiding to change the actual storage of data, just creating a view over them with the `get_a()` getter method 
// Left Rotation is equivalent to changing the access indexes 

contract LeftRoations {
    uint8[] public a; 
    uint256 internal start_index; 
    
    function set_a(uint8[] memory _a) public {
        a = _a; 
    }
    
    function get_a(uint256 index) public view returns (uint8) {
        return a[start_index + index];
    }
    
    function left_rotation(uint8 d) public {
        start_index = (start_index + d) % a.length; 
    }
}
