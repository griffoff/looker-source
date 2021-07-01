include: "/views/common_includes.lkml"

explore: settings_key_cache {hidden:yes}

view: settings_key_cache {
  derived_table: {
    explore_source: sdf_flattened {
      column: key { field: settings_key_values.key }
    }
  }
  dimension: key {}
}

view: settings_key_values {
  label: "Settings"
  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: HASH(${key}, ${value});;
    }
  dimension: key {
    label: "Setting Name"
    description: "Setting Name"
    sql:${TABLE}.value:key::STRING;;
    suggest_explore: settings_key_cache
    suggest_dimension: settings_key_cache.key
    }
  dimension: value {
    label: "Setting Value"
    description: "Setting value with the @type property removed"
    sql:
      CASE
        WHEN CHECK_JSON(${TABLE}.value:value) IS NOT NULL
        THEN OBJECT_DELETE(${TABLE}.value:value, '@type')::STRING
        ELSE ${TABLE}.value:value::STRING
        END
      ;;
    }
  dimension: value_type {
    label: "Setting Type"
    description: "The @type property of the setting value"
    sql: ${TABLE}.value:value:"@type"::STRING;;
  }
  measure: example_value {
    description: "An example of one of the used values of the current setting"
    type: string
    sql: ANY_VALUE(${value}) ;;
  }
  measure: value_count {
    label: "# Unique Values"
    description: "Number of different values"
    type:count_distinct
    sql: ${value} ;;
    }
  measure: key_count {
    label: "# Unique Settings"
    description: "Number of unique setting names"
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
  label: "Settings"
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
            JOIN LATERAL FLATTEN(container_children.value:children, outer=>True) course_settings
            JOIN LATERAL FLATTEN(COALESCE(course_settings.value:settingsGroup, container_children.value:settingsGroup)) settings_group ON settings_group.key != '@type'
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
      ;;

   sql_step:
    USE WAREHOUSE LOOKER
    ;;
    }
    persist_for: "24 hours"
  }

  dimension: pk {primary_key:yes hidden:yes}
  dimension: cgi {hidden:yes}
  dimension: checkpoint_id {hidden:yes}
  dimension: retrieval_id {hidden:yes}
  dimension: course_settings {hidden:yes}
  dimension: context_path {hidden:yes}
  dimension: context_path_type {hidden:yes}
  dimension: content_references {hidden:yes}
  dimension: instance_id {hidden:yes}
  dimension: settings_group {hidden:yes}
  dimension: settings_values {hidden:yes}
  dimension: settings_key_values {hidden:yes}
  measure: count { label:"SDF Flattened Count" type:count hidden:yes}
}
