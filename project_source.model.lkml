connection: "snowflake_prod"
label:"Source Data on Snowflake"

include: "*.view.lkml"


# Database Metadata
explore: schema_comparison {
  label: "Compare schemas: STG to PROD "
  join: table_comparison {
    sql_on: ${schema_comparison.schema_name} = ${table_comparison.schema_name};;
    relationship: one_to_many
  }
  join: column_comparison {
    sql_on: (${table_comparison.schema_name}, ${table_comparison.table_name}) = (${column_comparison.schema_name}, ${column_comparison.table_name}) ;;
    relationship: one_to_many
  }
}

explore: tables {
  label: "Information Schema"

  join: load_history {
    sql_on: ${tables.table_catalog} = ${load_history.table_catalog}
          and ${tables.table_schema} = ${load_history.schema_name}
          and ${tables.table_name} = ${load_history.table_name};;
    relationship: many_to_one
  }

  join: columns {
    sql_on:  ${tables.table_catalog} = ${columns.table_catalog}
          and ${tables.table_schema} = ${columns.table_schema}
          and ${tables.table_name} = ${columns.table_name};;
    relationship: many_to_one
  }
}


# CAFE

explore: cafe_eventing_client_activity_event {}
explore: cafe_eventing_wa_client_activity_event {}
explore: cafe_eventing_server_activity_event {}
explore: cafe_eventing_profile_event {}
explore: cafe_eventing_wa_profile_event {}


# CLTS
explore: olr_courses {
  label: "CLTS - Courses"
  join: entities{
    sql_on: ${olr_courses.entity_no} = ${entities.entity_no} ;;
    relationship: many_to_one
  }
  join: products {
    sql_on: ${olr_courses.isbn} = ${products.isbn13} ;;
    relationship: many_to_one
  }

  join: activations_olr {
    sql_on: ${olr_courses.context_id}=${activations_olr.context_id} ;;
    relationship: one_to_many
  }
}



# MindTap
explore: master {
  label: "MindTap - Master"
  from:  snapshot

  sql_always_where: ${is_master} = 1 ;;

  join: master_node {
    from: node
    sql_on: ${master.id} = ${master_node.snapshot_id} ;;
    relationship: one_to_many
  }

  join: snapshot {
    sql_on: ${master.id} = ${snapshot.source_id} ;;
    relationship: one_to_many
  }

  join: org {
    sql_on: ${snapshot.org_id} = ${org.id} ;;
    relationship: many_to_one
  }

  join: node {
    sql_on: (${snapshot.id},${master_node.id}) = (${node.snapshot_id},${node.origin_id}) ;;
    relationship: one_to_many
  }

  join: activity_outcome {
    sql_on: ${node.id} = ${activity_outcome.activity_id} ;;
    relationship: one_to_many
  }


}
explore: snapshot {
  label: "MindTap - Snapshot"

  # join to parent snapshot
  join: master {
    from:  snapshot
    sql_on: ${snapshot.parent_id} = ${master.id} ;;
    relationship: many_to_one
  }

  join:  org {
    sql_on: ${snapshot.org_id} = ${org.id} ;;
    relationship: one_to_one
  }

  join:  parent_org {
    from: org
    sql_on: ${org.parent_id} = ${parent_org.id} ;;
    relationship: one_to_one
  }

  join:  node {
    sql_on: ${snapshot.id} = ${node.snapshot_id} ;;
    relationship: one_to_many
  }

  join: user_org_profile {
    sql_on: ${snapshot.org_id} = ${user_org_profile.org_id} ;;
    relationship: one_to_many
  }

  join:  role {
    sql_on: ${user_org_profile.role_id} = ${role.id} ;;
    relationship: many_to_one
  }
  join: activity {
    sql_on:  ${node.id} = ${activity.id};;
    relationship: one_to_one
  }

  join: created_by_user {
    view_label: "User - Created By"
    from: user
    sql_on:  ${node.created_by} = ${created_by_user.id};;
    relationship: many_to_one
  }

  join: created_by_user_org_profile {
    from: user_org_profile
    sql_on: (${snapshot.org_id}, ${node.created_by}) = (${created_by_user_org_profile.org_id}, ${created_by_user_org_profile.user_id}) ;;
    relationship: one_to_one
  }

  join: created_by_role {
    from:  role
    sql_on: ${created_by_user_org_profile.role_id} = ${created_by_role.id} ;;
    relationship: many_to_one
  }

  join:  app_activity {
    sql_on: ${activity.app_activity_id} = ${app_activity.id} ;;
    relationship: many_to_one
  }

  join: app {
    sql_on: ${app_activity.app_id} = ${app.id} ;;
    relationship: many_to_one
  }

  join: activity_outcome {
    sql_on: ${node.id} = ${activity_outcome.activity_id} ;;
    relationship: one_to_many
  }

  join: activity_outcome_detail {
    sql_on: ${activity_outcome.id} = ${activity_outcome_detail.activity_outcome_id} ;;
    relationship: one_to_many
  }

  join: student {
    view_label: "User - Student"
    from: user
    sql_on:  ${activity_outcome.user_id} = ${student.id};;
    relationship: many_to_many
  }

}


# explore: ga_data_parsed {
#   label: "Google Analytics Data"
#   extends: [dim_course]
#   join: user_facts {
#     relationship: many_to_one
#     sql_on: ${ga_data_parsed.userssoguid} = ${user_facts.guid} ;;
#   }
#   join: dim_course {
#     relationship: many_to_one
#     sql_on: ${ga_data_parsed.coursekey} = ${dim_course.coursekey} ;;
#   }
#   join: dim_relative_to_start_date {
#     relationship: many_to_one
#     sql_on: datediff(days, ${olr_courses.begin_date_date}, ${ga_data_parsed.hit_date}) = ${dim_relative_to_start_date.days} ;;
#   }
# }
