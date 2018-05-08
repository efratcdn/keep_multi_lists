# keep_multi_lists
* Title       : For each in two lists
* Version     : 1.0
* Requires    : Specman 
* Modified    : May 2018
* Description :

[ More e code examples in https://github.com/efratcdn/spmn-e-utils ]


The macro implemented in e_util_keep_in_multi_lists.e enables applying same 
constraints on multiple lists
             
Macro syntax:

    keep for each in <list fields> {
        <constraints>;
    };  

Macro usage example:

    keep for each in [req_list, res_list] {
        .address == index;
        .kind == READ;
    };



See usage example for_each_in_multiple_lists_usage_ex.e
              
  specman -c 'load keep_in_multi_lists_usage_ex.e; test'
