keep_in_multi_lists_usage_ex.e

  
  Usage example of the e_util_for_each_in_multi_lists.e 
  

  Two examples - 
    In the first - having exactly same values in two lists, 
    In the second - having same distribution (using soft select) in three lists.
  
    specman -c 'load keep_in_multi_lists_usage_ex.e; test'
  
  
<'
import e_util_keep_in_multi_lists;

struct req {
    address : uint;
    value   : int;

    // additional fields...
    
    post_generate() is also {
        out("req ", address, " ", value);
    };
};
struct res {
    address : uint;
    value   : int;
    
    // additional fields...
    
    post_generate() is also {
        out("res ", address, " ", value);
    };
};

unit agent {
    req_list[4]  : list of req;
    res_list[4]  : list of res;
    
    // example 1 -  same values in the two lists
    keep for each in [req_list, res_list] {
        .address == index;
        .value == 4;
    };
};

type select_kind : [MOSTLY_LOW, MOSTLY_HIGH];
struct data_req {
    kind : select_kind;
    
    data_delay          : list of uint;
    req_delay           : list of uint;
    addr_delay          : list of uint;

    // example 2 - similar distribution in the three lists
    
    when MOSTLY_LOW data_req {
        keep for each in [data_delay, req_delay, addr_delay] {
            soft it == select {
                10   : [0];      -- Back to back
                2    : [1..5];   -- Short delay
                2    : [5..12];  -- Medium delay
                2    : [13..40]; -- Long delay
            };
        };
    };
    when MOSTLY_HIGH data_req {
        keep for each in [data_delay, req_delay, addr_delay] {
            soft it == select {
                1    : [0];      -- Back to back
                2    : [1..5];   -- Short delay
                2    : [5..12];  -- Medium delay
                10   : [13..40]; -- Long delay
            };
        };
    };
    
    
    post_generate() is also {
        out("\n", kind, "\n", data_delay);
        out(req_delay);
        out(addr_delay);
    };
};

extend sys {
    agent       : agent is instance;
    most_low_data_req  : MOSTLY_LOW data_req;
    most_high_data_req : MOSTLY_HIGH data_req;
};
'>