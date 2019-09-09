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
  extends: [cafe_eventing_base_activity]

  dimension: location {type: string}
  dimension: platform {type: string group_label: "Platform/Environment"}
}

view: cafe_eventing_base_client_activity {
  extension: required
  extends: [cafe_eventing_base_activity, cafe_eventing_base_client]
  dimension: event_duration {type: number group_label: "Event Details"}
  dimension: event_uri {type: string group_label: "Event Details"}
  dimension: user_platform {type: string group_label: "Platform/Environment"}
}
