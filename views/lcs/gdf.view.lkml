include: "/views/environment.view"
explore: gdf {hidden:yes}

view: gdf {
  extends: [environment]
  sql_table_name: "LCS".{% parameter environment %}."GDF"
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

  dimension: activity_group {
    type: string
    sql: ${TABLE}."ACTIVITY_GROUP" ;;
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

  dimension: category_definition_group {
    type: string
    sql: ${TABLE}."CATEGORY_DEFINITION_GROUP" ;;
  }

  dimension: cgi {
    type: string
    sql: ${TABLE}."CGI" ;;
  }

  dimension: checkpoint_id {
    type: string
    sql: ${TABLE}."CHECKPOINT_ID" ;;
  }

  dimension: course_group {
    type: string
    sql: ${TABLE}."COURSE_GROUP" ;;
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

  dimension: retrieval_id {
    type: string
    sql: ${TABLE}."RETRIEVAL_ID" ;;
  }

  dimension: revision_id {
    type: string
    sql: ${TABLE}."REVISION_ID" ;;
  }

  dimension: settings {
    type: string
    sql: ${TABLE}."SETTINGS" ;;
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
