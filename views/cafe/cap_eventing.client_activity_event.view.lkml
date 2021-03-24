include: "./cap_eventing.base.view"

view: all_tags {
  derived_table: {
    sql:
    SELECT DISTINCT t.value::STRING as tag_name
    FROM prod.datavault.sat_common_event_client_activity e
    CROSS JOIN LATERAL FLATTEN(OBJECT_KEYS(event_tags)) t
;;
    sql_trigger_value: SELECT COUNT(*) FROM prod.datavault.sat_common_event_client_activity ;;
    }

    dimension: tag_name {type: string primary_key:yes }
#     dimension: events_with_tag {type: number}
#     dimension: coverage {type:number value_format_name: percent_1}
#     dimension: example_value { type: string}
#     dimension: unique_values { type: number}
    measure: count {type: count}
}

explore: all_tags {hidden: yes}

view: tags {
  sql_table_name: lateral flatten(zandbox.pgriffiths.parse_tags(tags)) ;;

  dimension: key {
    label: "Tag Name"
    suggest_dimension: all_tags.tag_name
    suggest_explore: all_tags
  }
  dimension: value {
    label: "Tag Value"
    sql: ${TABLE}.value::STRING ;;
  }
}

view: cafe_eventing_client_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.{% parameter environment %}.client_activity_event ;;

  view_label: "CAFE Events - Client activity events"

  dimension: event_id {
    hidden: yes
    primary_key: yes
  }


}


view: cafe_eventing_wa_client_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.{% parameter environment %}.wa_client_activity_event ;;

  view_label: "CAFE Events - WebAssign client activity events"
}

view: cafe_eventing_cap_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.{% parameter environment %}.cap_activity_event ;;

  view_label: "CAFE Events - CAP activity events"
}
