File name     : e_util_keep_in_multi_lists.e
Title         : Keep for each in two lists
Project       : Utilities examples
Created       : 2018
Description   : 
              : The macro "keep for each in [lists]" enables defining same constraints 
              : for multiple lists
              :
Example       : See usage example for_each_in_multiple_lists_usage_ex.e
              : 
                
  specman -c 'load keep_in_multiple_lists_usage_ex.e; test'

<'
define <multi_keep_for'struct_member> "keep for each in \[<detr'name>,...\] (<MEMBERS>{<any>;...})" as computed {
    for each in <detr'names> do {
        result = appendf("%s; keep for each in %s %s", result, it, <MEMBERS>);
    };
};
'>