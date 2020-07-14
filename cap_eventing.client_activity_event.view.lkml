include: "cap_eventing.base.view"

view: cafe_eventing_client_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.{% parameter environment %}.client_activity_event ;;

  dimension: tags_course_key {
    type: string
  #   sql: ${TABLE}."TAGS"[0]:value::STRING  ;;
    sql: case
      when ${TABLE}."TAGS"[0]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[0]:value::STRING
      when ${TABLE}."TAGS"[1]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[1]:value::STRING
      when ${TABLE}."TAGS"[2]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[2]:value::STRING
      when ${TABLE}."TAGS"[3]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[3]:value::STRING
      when ${TABLE}."TAGS"[4]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[4]:value::STRING
      when ${TABLE}."TAGS"[5]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[5]:value::STRING
      when ${TABLE}."TAGS"[6]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[6]:value::STRING
      when ${TABLE}."TAGS"[7]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[7]:value::STRING
      when ${TABLE}."TAGS"[8]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[8]:value::STRING
      when ${TABLE}."TAGS"[9]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[9]:value::STRING
      when ${TABLE}."TAGS"[10]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[10]:value::STRING
      when ${TABLE}."TAGS"[11]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[11]:value::STRING
      when ${TABLE}."TAGS"[12]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[12]:value::STRING
      when ${TABLE}."TAGS"[13]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[13]:value::STRING
      when ${TABLE}."TAGS"[14]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[14]:value::STRING
      when ${TABLE}."TAGS"[15]:key::STRING = 'courseKey' then ${TABLE}."TAGS"[15]:value::STRING
      else null
    end
    ;;
    label: "Course key"
  }

  dimension: tags_search_term {
    type: string
    sql: case
      when ${TABLE}."TAGS"[0]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[0]:value::STRING
      when ${TABLE}."TAGS"[1]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[1]:value::STRING
      when ${TABLE}."TAGS"[2]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[2]:value::STRING
      when ${TABLE}."TAGS"[3]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[3]:value::STRING
      when ${TABLE}."TAGS"[4]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[4]:value::STRING
      when ${TABLE}."TAGS"[5]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[5]:value::STRING
      when ${TABLE}."TAGS"[6]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[6]:value::STRING
      when ${TABLE}."TAGS"[7]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[7]:value::STRING
      when ${TABLE}."TAGS"[8]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[8]:value::STRING
      when ${TABLE}."TAGS"[9]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[9]:value::STRING
      when ${TABLE}."TAGS"[10]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[10]:value::STRING
      when ${TABLE}."TAGS"[11]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[11]:value::STRING
      when ${TABLE}."TAGS"[12]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[12]:value::STRING
      when ${TABLE}."TAGS"[13]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[13]:value::STRING
      when ${TABLE}."TAGS"[14]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[14]:value::STRING
      when ${TABLE}."TAGS"[15]:key::STRING = 'searchTerm' then ${TABLE}."TAGS"[15]:value::STRING
      else null
    end ;;
    label: "Search Term"
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

# view: cafe_eventing_client_activity_event_nonprod {
#   extends: [cafe_eventing_client_activity_event]
#   parameter: environment {default_value:"NONPROD"}
# }


view: cafe_eventing_wa_client_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.{% parameter environment %}.wa_client_activity_event ;;
}
