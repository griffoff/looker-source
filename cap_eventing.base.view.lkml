named_value_format: duration_mins {
  value_format: "[m] \m\i\n\s"
}

view: cafe_eventing_base {
  extension: required

  dimension_group: _ldts {
    type: time
    label:"Load"
    timeframes: [year, month, month_name, week, week_of_year, date, time, hour, hour_of_day, minute]
  }
  dimension: _rsrc {type: string label:"Record Source (_RSRC)"}
  dimension: message_format_version {type: number group_label: "Message Details"}
  dimension: message_type {type: string group_label: "Message Details"}
  dimension: product_platform {type: string group_label: "Platform/Environment"}
  dimension: product_environment {type: string group_label: "Platform/Environment"}
  dimension_group: event_time {
    type: time
    label:"Event"
    timeframes: [year, month, month_name, week, week_of_year, date, time, hour, hour_of_day, minute]
  }

  measure: count {
    label: "# events"
    type: count
  }

}

view: cafe_eventing_base_client {
  extension: required
  extends: [cafe_eventing_base]

  dimension: host_platform {type: string group_label: "Platform/Environment"}
  dimension: host_environment {type: string group_label: "Platform/Environment"}
  dimension: session_id {type: string group_label: "Event Details"}

}

view: cafe_eventing_base_activity {
  extension: required
  extends: [cafe_eventing_base]

  dimension: event_category {type: string group_label:"Event Details"}
  dimension: event_action {type: string group_label:"Event Details"}
  dimension: event_id {type: string group_label:"Event Details"}
  dimension: user_environment {type: string group_label: "Platform/Environment"}
  dimension: user_sso_guid {type: string}
  dimension: tags {type: string}

  measure: user_count {
    label: "# users"
    type: count_distinct
    sql: ${user_sso_guid} ;;
  }

}

view: cafe_eventing_base_profile_event {
  extension: required
  extends: [cafe_eventing_base]

  dimension: location {group_label: "Location" type: string}
  dimension: location_ip {group_label: "Location" sql:${location}:ipAddress::STRING;; type: string}
  dimension: location_tz {group_label: "Location" sql:${location}:timeZone::STRING;; type: string}
  dimension: platform {group_label: "Platform" type: string }
  dimension: platform_browserFingerprint {group_label: "Platform" type:string sql:${platform}:browserFingerprint::STRING;; hidden:yes}
  dimension: platform_browserName {group_label: "Platform" type:string sql:${platform}:browserName::STRING;; }
  dimension: platform_browserVersion {group_label: "Platform" type:string sql:${platform}:browserVersion::STRING;; }
  dimension: platform_engineName {group_label: "Platform" type:string sql:${platform}:engineName::STRING;; }
  dimension: platform_language {group_label: "Platform" type:string sql:${platform}:language::STRING;; }
  dimension: platform_osName {group_label: "Platform" type:string sql:${platform}:osName::STRING;; }
  dimension: platform_osVersionName {group_label: "Platform" type:string sql:${platform}:osVersionName::STRING;; }
  dimension: platform_platformType {group_label: "Platform" type:string sql:${platform}:platformType::STRING;; }
  dimension: platform_screenResolution {group_label: "Platform" type:string sql:${platform}:screenResolution::STRING;; }
  dimension: platform_userAgentString {group_label: "Platform" type:string sql:${platform}:userAgentString::STRING;; hidden:yes}

}

view: cafe_eventing_base_client_activity {
  extension: required
  extends: [cafe_eventing_base_activity, cafe_eventing_base_client]

  dimension: event_duration {
    description: "Duration (mins)"
    type: number
    group_label: "Event Details"
    sql: ${TABLE}.event_duration / 3600 / 24 ;;
    value_format_name: duration_mins
  }
  measure: event_duration_avg  {
    group_label: "Duration"
    label: "Duration (Avg per event)"
    type: average
    sql: ${event_duration} ;;
    value_format_name: duration_mins
  }
  measure: event_duration_total  {
    group_label: "Duration"
    label: "Duration (Total)"
    type: average
    sql: ${event_duration} ;;
    value_format_name: duration_mins
  }
  measure: event_duration_avg_per_user  {
    group_label: "Duration"
    label: "Duration (Avg per user)"
    type: number
    sql: ${event_duration_total} / ${user_count} ;;
    value_format_name: duration_mins
  }

  dimension: event_uri {type: string group_label: "Event Details"}
  dimension: user_platform {type: string group_label: "Platform/Environment"}

  measure: count_unique {
    label: "# unique events"
    type: count_distinct
    sql: ${event_uri} ;;
  }
}
