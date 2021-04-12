explore: cafe_flow_analysis{
  description: "This is a tool to allow you to see the path that users follow in terms of the events we capture via CAFE"
  hidden: yes
  always_filter: {filters: [cafe_flow_analysis.date_range_filter: "after 7 days ago", cafe_flow_analysis.product_platform_filter: ""]}
}

view: cafe_flow_analysis {
  filter: date_range_filter {
    label: "Choose a starting date range"
    description: "Select a date range for the starting event(s)"
    type: date
    datatype: date
  }

  filter: first_event_category {
    label: "Select the first event category"
    type: string
    suggest_explore: client_activity_event
    suggest_dimension: cafe_eventing_client_activity_event.event_category
  }

  filter: product_platform_filter {
    suggest_explore: cafe_eventing_client_activity_event
    suggest_dimension: cafe_eventing_client_activity_event.product_platform

  }

  derived_table: {
    sql:
    WITH events AS (
      SELECT
        user_sso_guid
        ,event_time
        ,event_category
        ,event_action
        ,cu_user_analysis.event_name_from_source('CLIENT ACTIVITY EVENTS', host_platform, event_category, event_action, NULL) AS event_name
        ,LAG(event_name) OVER (PARTITION BY user_sso_guid ORDER BY event_time) = event_name AS duplicate
      FROM cap_eventing.prod.client_activity_event
      WHERE {% condition date_range_filter %} event_time {% endcondition%}
      AND {% condition product_platform_filter %} product_platform {% endcondition %}

    )
    ,event_sequence AS (
      SELECT
        *
        ,ROW_NUMBER() OVER (PARTITION BY user_sso_guid ORDER BY event_time) AS sequence
      FROM events
      WHERE NOT duplicate
    )
    ,results AS (
      SELECT
        user_sso_guid
        ,MAX(CASE WHEN sequence = 1 THEN event_category END) as event_category_1
        ,MAX(CASE WHEN sequence = 1 THEN event_name END) as event_1
        ,MAX(CASE WHEN sequence = 2 THEN event_name END) as event_2
        ,MAX(CASE WHEN sequence = 3 THEN event_name END) as event_3
        ,MAX(CASE WHEN sequence = 4 THEN event_name END) as event_4
        ,MAX(CASE WHEN sequence = 5 THEN event_name END) as event_5
        ,MAX(CASE WHEN sequence = 6 THEN event_name END) as event_6
        ,MAX(CASE WHEN sequence = 7 THEN event_name END) as event_7
        ,MAX(CASE WHEN sequence = 8 THEN event_name END) as event_8
        ,MAX(CASE WHEN sequence = 9 THEN event_name END) as event_9
      FROM event_sequence
      WHERE sequence <= 9
      GROUP BY 1
    )
    SELECT *
    FROM results
    WHERE {% condition first_event_category %} event_category_1 {% endcondition %}

      ;;
  }

  dimension: user_sso_guid {hidden:yes}

  dimension: event_1 {}
  dimension: event_2 {}
  dimension: event_3 {}
  dimension: event_4 {}
  dimension: event_5 {}
  dimension: event_6 {}
  dimension: event_7 {}
  dimension: event_8 {}
  dimension: event_9 {}

  measure: user_count {
    type: count_distinct
    sql: ${user_sso_guid}  ;;
  }

  measure: count {
    type: count
  }
}
