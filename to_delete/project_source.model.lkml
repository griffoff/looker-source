connection: "snowflake_prod"
# label:"Source Data on Snowflake"

# include: "/views/cafe/*.view.lkml"


# Database Metadata
# explore: schema_comparison {
#   label: "Compare schemas: STG to PROD "
#   join: table_comparison {
#     sql_on: ${schema_comparison.schema_name} = ${table_comparison.schema_name};;
#     relationship: one_to_many
#   }
#   join: column_comparison {
#     sql_on: (${table_comparison.schema_name}, ${table_comparison.table_name}) = (${column_comparison.schema_name}, ${column_comparison.table_name}) ;;
#     relationship: one_to_many
#   }
# }

# explore: tables {
#   label: "Information Schema"

#   join: load_history {
#     sql_on: ${tables.table_catalog} = ${load_history.table_catalog}
#           and ${tables.table_schema} = ${load_history.schema_name}
#           and ${tables.table_name} = ${load_history.table_name};;
#     relationship: many_to_one
#   }

#   join: columns {
#     sql_on:  ${tables.table_catalog} = ${columns.table_catalog}
#           and ${tables.table_schema} = ${columns.table_schema}
#           and ${tables.table_name} = ${columns.table_name};;
#     relationship: many_to_one
#   }
# }


# CAFE



# CLTS
# explore: olr_courses {
#   label: "CLTS - Courses"
#   join: entities{
#     sql_on: ${olr_courses.entity_no} = ${entities.entity_no} ;;
#     relationship: many_to_one
#   }
#   join: products {
#     sql_on: ${olr_courses.isbn} = ${products.isbn13} ;;
#     relationship: many_to_one
#   }

#   join: activations_olr {
#     sql_on: ${olr_courses.context_id}=${activations_olr.context_id} ;;
#     relationship: one_to_many
#   }
# }
