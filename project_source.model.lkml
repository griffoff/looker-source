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

explore: cafe_events_base_explore {
  from: cafe_eventing_client_activity_event
  view_name: cafe_eventing_client_activity_event
  hidden:yes
  always_filter: {
    filters: [cafe_eventing_client_activity_event.event_time_date: "7 days"]
    }

  join: tags {
    type: cross
    relationship: one_to_many
  }

  query: cafe_recent_new_events {
    label: "New CAFE events in the last 7 days"
    description: "Use this starting point to see events that have been sent for the first time in the last 7 days.
    You can further filter by environment or platform"
    dimensions: [
      cafe_eventing_client_activity_event.product_platform
      ,cafe_eventing_client_activity_event.event_category
      ,cafe_eventing_client_activity_event.event_action]
    measures: [cafe_eventing_client_activity_event.count]
    sorts: [cafe_eventing_client_activity_event.product_platform: asc, cafe_eventing_client_activity_event.count: desc]
    filters: [
      cafe_eventing_client_activity_event.environment: "PROD"
      ,cafe_eventing_client_activity_event.event_time_date: ""
      ,cafe_eventing_client_activity_event.earliest_event: "7 days"
      ]
    limit: 500
  }

  query: cafe_recent_hourly_events{
    label: "User Counts for the last 48 hours by platform"
    description: "Hourly number of users who have generated CAFE events by platform for the last 48 hours
    "
    dimensions: [cafe_eventing_client_activity_event.event_time_hour, cafe_eventing_client_activity_event.product_platform]
    pivots: [cafe_eventing_client_activity_event.product_platform]
    measures: [cafe_eventing_client_activity_event.user_count]
    filters: [
      cafe_eventing_client_activity_event.environment: "PROD",
      cafe_eventing_client_activity_event.event_time_date: "48 hours"
    ]
  }

  query: cafe_recent_event_tags {
    label: "CAFE tag names received in the last day"
    description: "See the different tags that have been received in CAFE events in the last 24 hours"
    dimensions: [cafe_eventing_client_activity_event.product_platform, tags.key]
    measures: [cafe_eventing_client_activity_event.count]
    filters: [
      cafe_eventing_client_activity_event.event_time_date: "1 days",
      tags.key: "-EMPTY"
    ]
  }

  query: cafe_tag_values {
    label: "Event Counts for CAFE tag values"
    description: "
    This shows you the number of events recived with specific values in the tag for a specific tag name.
    Default filters are set so that we see the number of times the CU-Sidebar carousel has been clicked and which pane was clicked on.
    The pie chart vizualization is a good one to use for this"
    dimensions: [tags.value]
    measures: [cafe_eventing_client_activity_event.count]
    filters: [
      cafe_eventing_client_activity_event.event_time_date: "7 days",
      cafe_eventing_client_activity_event.product_platform: "cu-side-bar",
      tags.key: "carouselName"
    ]
  }

}

explore: cafe_eventing_client_activity_event {
  extends: [cafe_events_base_explore]
  hidden: no
}
explore: cafe_eventing_cap_activity_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_cap_activity_event view_name:cafe_eventing_client_activity_event}
# other explores have the same view name so that you can change the view by changing the view name in the url
explore: cafe_eventing_wa_client_activity_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_wa_client_activity_event view_name:cafe_eventing_client_activity_event}
explore: cafe_eventing_server_activity_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_server_activity_event view_name:cafe_eventing_client_activity_event}
explore: cafe_eventing_profile_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_profile_event view_name:cafe_eventing_client_activity_event}
explore: cafe_eventing_wa_profile_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_wa_profile_event view_name:cafe_eventing_client_activity_event}
explore: cafe_eventing_client_profile_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_client_profile_event view_name:cafe_eventing_client_activity_event}


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



# # MindTap
# explore: master {
#   label: "MindTap - Master"
#   from:  snapshot
#
#   sql_always_where: ${is_master} = 1 ;;
#
#   join: master_node {
#     from: node
#     sql_on: ${master.id} = ${master_node.snapshot_id} ;;
#     relationship: one_to_many
#   }
#
#   join: snapshot {
#     sql_on: ${master.id} = ${snapshot.source_id} ;;
#     relationship: one_to_many
#   }
#
#   join: org {
#     sql_on: ${snapshot.org_id} = ${org.id} ;;
#     relationship: many_to_one
#   }
#
#   join: node {
#     sql_on: (${snapshot.id},${master_node.id}) = (${node.snapshot_id},${node.origin_id}) ;;
#     relationship: one_to_many
#   }
#
#   join: activity_outcome {
#     sql_on: ${node.id} = ${activity_outcome.activity_id} ;;
#     relationship: one_to_many
#   }
#
#
# }
# explore: snapshot {
#   label: "MindTap - Snapshot"
#
#   # join to parent snapshot
#   join: master {
#     from:  snapshot
#     sql_on: ${snapshot.parent_id} = ${master.id} ;;
#     relationship: many_to_one
#   }
#
#   join:  org {
#     sql_on: ${snapshot.org_id} = ${org.id} ;;
#     relationship: one_to_one
#   }
#
#   join:  parent_org {
#     from: org
#     sql_on: ${org.parent_id} = ${parent_org.id} ;;
#     relationship: one_to_one
#   }
#
#   join:  node {
#     sql_on: ${snapshot.id} = ${node.snapshot_id} ;;
#     relationship: one_to_many
#   }
#
#   join: user_org_profile {
#     sql_on: ${snapshot.org_id} = ${user_org_profile.org_id} ;;
#     relationship: one_to_many
#   }
#
#   join:  role {
#     sql_on: ${user_org_profile.role_id} = ${role.id} ;;
#     relationship: many_to_one
#   }
#   join: activity {
#     sql_on:  ${node.id} = ${activity.id};;
#     relationship: one_to_one
#   }
#
#   join: created_by_user {
#     view_label: "User - Created By"
#     from: user
#     sql_on:  ${node.created_by} = ${created_by_user.id};;
#     relationship: many_to_one
#   }
#
#   join: created_by_user_org_profile {
#     from: user_org_profile
#     sql_on: (${snapshot.org_id}, ${node.created_by}) = (${created_by_user_org_profile.org_id}, ${created_by_user_org_profile.user_id}) ;;
#     relationship: one_to_one
#   }
#
#   join: created_by_role {
#     from:  role
#     sql_on: ${created_by_user_org_profile.role_id} = ${created_by_role.id} ;;
#     relationship: many_to_one
#   }
#
#   join:  app_activity {
#     sql_on: ${activity.app_activity_id} = ${app_activity.id} ;;
#     relationship: many_to_one
#   }
#
#   join: app {
#     sql_on: ${app_activity.app_id} = ${app.id} ;;
#     relationship: many_to_one
#   }
#
#   join: activity_outcome {
#     sql_on: ${node.id} = ${activity_outcome.activity_id} ;;
#     relationship: one_to_many
#   }
#
#   join: activity_outcome_detail {
#     sql_on: ${activity_outcome.id} = ${activity_outcome_detail.activity_outcome_id} ;;
#     relationship: one_to_many
#   }
#
#   join: latest_take {
#     sql_on: ${activity_outcome_detail.id} = ${latest_take.aod_id} ;;
#     relationship: one_to_one
#   }
#
#   join: student {
#     view_label: "User - Student"
#     from: user
#     sql_on:  ${activity_outcome.user_id} = ${student.id};;
#     relationship: many_to_many
#   }
#
# }
#
# explore: activity {
#   join: activity_outcome {
#     sql_on: ${activity.id} = ${activity_outcome.activity_id};;
#     relationship: one_to_many
#     type: inner
#   }
#   join: activity_outcome_detail {
#     sql_on: ${activity_outcome.id} = ${activity_outcome_detail.activity_outcome_id} ;;
#     relationship: one_to_many
#     type: inner
#   }
# }

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
