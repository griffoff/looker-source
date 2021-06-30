include: "/views/common_includes.lkml"

view: settings_key_values {
  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: HASH(${key}, ${value});;
    }
  dimension: key {sql:${TABLE}.value:key::STRING;;}
  dimension: value {sql: ${TABLE}.value:value::STRING;;}
  measure: example_value {
    type: string
    sql: ANY_VALUE(${value}) ;;
  }
  measure: count { type:count}
  measure: value_count {
    type:count_distinct
    sql: ${value} ;;
    }
  measure: key_count {
    type:count_distinct
    sql: ${key} ;;
  }
}

explore: sdf_flattened {
  extends: [root]
  join: sdf_flattened {
    sql_on:TRUE;; relationship:one_to_many
    }
  join: settings_key_values {
    sql: CROSS JOIN LATERAL FLATTEN(${sdf_flattened.settings_key_values}, outer=>TRUE) settings_key_values ;;
    relationship: one_to_many
  }
}

view: sdf_flattened {
  derived_table: {
    create_process: {
      sql_step: USE WAREHOUSE HEAVYDUTY
      ;;

      sql_step:
        CREATE OR REPLACE TRANSIENT TABLE ${SQL_TABLE_NAME}
        AS
         SELECT
          HASH(settings.cgi, settings.checkpoint_id) as pk
          , settings.cgi
          , settings.checkpoint_id
          , settings.retrieval_id
          , settings.course_settings
          , course_settings.value:contextPath       AS context_path
          , course_settings.value:contextPathType   AS context_path_type
          , course_settings.value:contentReferences AS content_references
          , course_settings.value:instanceId        AS instance_id
          , course_settings.value:settingsGroup     AS settings_group
          , ARRAY_AGG(OBJECT_CONSTRUCT('key', settings_group.key, 'value', settings_group.value)) as settings_key_values
          , ARRAY_AGG(OBJECT_CONSTRUCT(settings_group.key, settings_group.value)) as settings_values
        FROM lcs.prod.sdf settings
            JOIN LATERAL FLATTEN(course_settings) containers ON containers.key = 'containers'
            JOIN LATERAL FLATTEN(containers.value) container_children
            JOIN LATERAL FLATTEN(container_children.value:children) course_settings
            JOIN LATERAL FLATTEN(course_settings.value:settingsGroup) settings_group ON settings_group.key != '@type'
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
      ;;

   sql_step:
    USE WAREHOUSE LOOKER
    ;;
    }
    persist_for: "24 hours"
  }

  dimension: pk {primary_key:yes hidden:yes}
  dimension: cgi {}
  dimension: checkpoint_id {}
  dimension: retrieval_id {}
  dimension: course_settings {}
  dimension: context_path {}
  dimension: context_path_type {}
  dimension: content_references {}
  dimension: instance_id {}
  dimension: settings_group {}
  dimension: settings_values {}
  dimension: settings_key_values {}
  measure: count { type:count}
}
