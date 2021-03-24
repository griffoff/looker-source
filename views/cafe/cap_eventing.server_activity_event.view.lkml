include: "./cap_eventing.base.view"

view: cafe_eventing_server_activity_event {
  extends: [cafe_eventing_base_activity]
  sql_table_name: cap_eventing.{% parameter environment %}.server_activity_event ;;

  view_label: "CAFE Events - Server activity events"

  parameter: environment {
    default_value: "PROD"
    type: unquoted
    allowed_value: {label: "Production Data" value: "PROD"}
    allowed_value: {label: "Lower Environment Data" value: "NONPROD"}
  }
  dimension: event_value {type: number}
}
