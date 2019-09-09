include: "cap_eventing.base.view"

view: cafe_eventing_server_activity_event {
  extends: [cafe_eventing_base_activity]
  sql_table_name: cap_eventing.prod.server_activity_event ;;
  dimension: event_value {type: number}
}
