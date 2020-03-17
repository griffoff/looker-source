include: "cap_eventing.base.view"

view: cafe_eventing_client_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.prod.client_activity_event ;;

dimension: tags_course_key {
  type: string
  sql: ${TABLE}."TAGS"[0]:value::STRING  ;;
  label: "Course key"
}

#   dimension: tags_key {
#     type: string
#     sql: ${TABLE}."TAGS"[0]:key::STRING  ;;
#     label: "key"
#   }
#
#   measure: example_tags  {
#     type: string
#     sql: any_value(${TABLE}.tags) ;;
#   }

}

view: cafe_eventing_wa_client_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.prod.wa_client_activity_event ;;
}
