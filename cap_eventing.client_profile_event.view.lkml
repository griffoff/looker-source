include: "cap_eventing.base.view"

view: cafe_eventing_profile_event {
  extends: [cafe_eventing_base_profile_event]
  sql_table_name: cap_eventing.prod.client_profile_event ;;
}

view: cafe_eventing_wa_profile_event {
  extends: [cafe_eventing_base_profile_event]
  sql_table_name: cap_eventing.prod.wa_client_profile_event ;;
}
