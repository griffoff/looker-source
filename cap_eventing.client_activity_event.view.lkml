include: "cap_eventing.base.view"

view: all_tags {
  derived_table: {
    sql:
    SELECT t.key AS tag_name
         , COUNT(e.*) as events_with_tag
         , events_with_tag / MAX(c.total_events) as coverage
         , ANY_VALUE(t.value)::STRING AS example_value
         , count(DISTINCT t.value) AS unique_values
    FROM prod.datavault.sat_common_event_client_activity e
        CROSS JOIN LATERAL flatten(event_tags) t
        CROSS JOIN (SELECT COUNT(*) AS total_events FROM prod.datavault.sat_common_event_client_activity) c
    GROUP BY 1
    ;;
    sql_trigger_value: SELECT COUNT(*) FROM prod.datavault.sat_common_event_client_activity ;;
    }

    dimension: tag_name {type: string primary_key:yes }
    dimension: events_with_tag {type: number}
    dimension: coverage {type:number value_format_name: percent_1}
    dimension: example_value { type: string}
    dimension: unique_values { type: number}
    measure: count {type: count}
}

explore: all_tags {hidden: no}

view: cafe_eventing_client_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.{% parameter environment %}.client_activity_event ;;

  view_label: "CAFE Events - Client activity events"

  filter: select_tag {
    description: "Select a tag you would like to analyse - use the event_tag dimension in an explore.  If you don't filter on event_date, this will take up to 10 minutes to run. Consider adding event_tag NOT NULL as a filter"
    type: string
    suggest_dimension: all_tags.tag_name
    suggest_explore: all_tags
    suggest_persist_for: "24 hours"
    default_value: ""
    required_fields: [event_tag]
  }

  dimension: event_tag {
    type: string
    sql: GET_PATH(zandbox.pgriffiths.parse_tags(tags), {% parameter select_tag %}) ;;
  }

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

}


view: cafe_eventing_wa_client_activity_event {
  extends: [cafe_eventing_base_client_activity]
  sql_table_name: cap_eventing.{% parameter environment %}.wa_client_activity_event ;;

  view_label: "CAFE Events - WebAssign client activity events"
}
