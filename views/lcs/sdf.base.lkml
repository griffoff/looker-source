view: sdf {
  sql_table_name: "LCS".{% parameter explore_level_parameters.schema_name %}."SDF"
    ;;

  dimension_group: _ldts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."_LDTS" ;;
  }

  dimension: _rsrc {
    type: string
    sql: ${TABLE}."_RSRC" ;;
  }

  dimension: attributes {
    type: string
    sql: ${TABLE}."ATTRIBUTES" ;;
  }

  dimension_group: batch_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."BATCH_START_DATE" ;;
  }

  dimension: cgi {
    description: "Global Identifier for Settings File"
    type: string
    sql: ${TABLE}."CGI" ;;
  }

  dimension: checkpoint_id {
    type: string
    sql: ${TABLE}."CHECKPOINT_ID" ;;
  }

  dimension: containers {
    type: string
    sql: ${TABLE}."CONTAINERS" ;;
  }

  dimension: course_settings {
    type: string
    sql: ${TABLE}."COURSE_SETTINGS" ;;
  }

  dimension: created_by {
    type: string
    sql: ${TABLE}."CREATED_BY" ;;
  }

  dimension_group: creation {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATION_DATE" ;;
  }

  dimension: exception {
    type: string
    sql: ${TABLE}."EXCEPTION" ;;
  }

  dimension: platform_settings {
    type: string
    sql: ${TABLE}."PLATFORM_SETTINGS" ;;
  }

  dimension: retrieval_id {
    type: string
    sql: ${TABLE}."RETRIEVAL_ID" ;;
  }

  dimension: revision_id {
    type: string
    sql: ${TABLE}."REVISION_ID" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TENANT_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
