include: "cap_eventing.base.view"

view: cafe_eventing_client_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.prod.client_activity_event ;;
}

view: cafe_eventing_client_activity_event_nonprod {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.nonprod.client_activity_event ;;
}


view: cafe_eventing_wa_client_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.prod.wa_client_activity_event ;;
}
