#include "module_library.h"
#include "../framework/module_creator.h"  // for create_mc

// Include all the header files that define the modules.
//#include "example_module.h"
#include "partitioning_coefficient_logistic.h"
#include "miscanthus_senescence.h"
#include "delta_TT.h"

creator_map MiscanthusBML::module_library::library_entries =
{
//    {"example_module", &create_mc<example_module>}
    {"partitioning_coefficient_logistic",       &create_mc<partitioning_coefficient_logistic>},
    {"miscanthus_senescence",                   &create_mc<miscanthus_senescence>},
    {"delta_TT",                                &create_mc<delta_TT>}
};
