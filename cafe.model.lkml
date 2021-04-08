connection: "snowflake_prod"

include: "/views/cafe/*.view.lkml"                # include all views in the views/ folder in this project


explore: +cafe_flow_analysis{
  hidden: no
  always_filter: {filters: [cafe_flow_analysis.date_range_filter: "7 days", cafe_flow_analysis.product_platform_filter: ""]}
}

explore: cafe_events_base_explore {
  from: cafe_eventing_client_activity_event
  view_name: cafe_events
  hidden:yes
  always_filter: {
    filters: [cafe_events.event_time_date: "7 days", cafe_events.environment: "PROD"]
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
      cafe_events.product_platform
      ,cafe_events.event_category
      ,cafe_events.event_action]
    measures: [cafe_events.count]
    sorts: [cafe_events.product_platform: asc, cafe_events.count: desc]
    filters: [
      cafe_events.environment: "PROD"
      ,cafe_events.event_time_date: "after 2018/01/01"
      ,cafe_events.earliest_event: "7 days"
    ]
    limit: 500
  }

  query: cafe_recent_hourly_events{
    label: "User Counts for the last 48 hours by platform"
    description: "Hourly number of users who have generated CAFE events by platform for the last 48 hours
    "
    dimensions: [cafe_events.event_time_hour, cafe_events.product_platform]
    pivots: [cafe_events.product_platform]
    measures: [cafe_events.user_count]
    filters: [
      cafe_events.environment: "PROD",
      cafe_events.event_time_date: "48 hours"
    ]
  }

  query: cafe_recent_event_tags {
    label: "CAFE tag names received in the last day"
    description: "See the different tags that have been received in CAFE events in the last 24 hours"
    dimensions: [cafe_events.product_platform, tags.key]
    measures: [cafe_events.count]
    filters: [
      cafe_events.event_time_date: "1 days",
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
    measures: [cafe_events.count]
    filters: [
      cafe_events.event_time_date: "7 days",
      cafe_events.product_platform: "cu-side-bar",
      tags.key: "carouselName"
    ]
  }

}

explore: cafe_eventing_client_activity_event {
  extends: [cafe_events_base_explore]
  hidden: no
}
explore: cafe_eventing_cap_activity_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_cap_activity_event view_name:cafe_events}
# other explores have the same view name so that you can change the view by changing the view name in the url
explore: cafe_eventing_wa_client_activity_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_wa_client_activity_event view_name:cafe_events}
explore: cafe_eventing_server_activity_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_server_activity_event view_name:cafe_events}
explore: cafe_eventing_profile_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_profile_event view_name:cafe_events}
explore: cafe_eventing_wa_profile_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_wa_profile_event view_name:cafe_events}
explore: cafe_eventing_client_profile_event {extends: [cafe_events_base_explore] hidden: no from: cafe_eventing_client_profile_event view_name:cafe_events}
