pragma solidity >=0.8.0 <0.9.0;

contract linked_list {
    struct node {
        uint256 value;
        uint256 next;
        bool has_next; 
    }
    
    node[] public data;
    uint256 internal idx_base; 
    uint256 internal length;
    
    
    function insert(uint256 val, uint256 pos) external {
        require(pos <= data.length, "Length");
        if (data.length==0) {
            // First Element 
            data.push(node( val, idx_base, false ));
            idx_base = 0; 
        }
        else if (pos==0) {
            data.push(node( val, idx_base, true ));
            idx_base = data.length-1; 
        }
        else {
            uint256 idx = idx_base; 
            for(uint256 i=2; i<=pos; ++i) {
                idx = data[idx].next; 
            }
            data.push(node(val, data[idx].next, data[idx].has_next));
            data[idx].next = data.length-1;
            data[idx].has_next = true; 
        }
    }
    
    function get(uint256 idx) view external returns(uint256) {
        require(idx < data.length, "Length");
        uint256 _idx = idx_base; 
        for (uint256 i=1; i<=idx; ++i) {
                _idx = data[_idx].next; 
        }
        return data[_idx].value; 
    }    
}

