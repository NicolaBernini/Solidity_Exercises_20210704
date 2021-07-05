pragma solidity ^0.5.0; 
pragma experimental ABIEncoderV2;

contract Users{
    struct user_data{
        string name; 
        uint8 age;
        
    }
    
    struct _user_data{
        user_data data;
        bool is_present;
    }
    
    mapping(address => _user_data) data; 
    
    function set(string memory name, uint8 age) public {
        data[msg.sender].data.name = name; 
        data[msg.sender].data.age = age; 
        data[msg.sender].is_present = true; 
    }
    
    function get() public view returns (user_data memory) {
        require(data[msg.sender].is_present, "User not registered");
        return data[msg.sender].data; 
    }
    
}


