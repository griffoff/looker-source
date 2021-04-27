include: "//core/datagroups.lkml"

view: adf {

  derived_table: {
    sql:
      WITH a AS (
      SELECT *, LEAD(_ldts) OVER(PARTITION BY checkpoint_id, retrieval_id) IS NULL AS _latest
      FROM "LCS".{% parameter explore_level_parameters.schema_name %}."ADF"
      )
      SELECT *
      FROM a
      WHERE _latest
      ;;

      datagroup_trigger: daily_refresh
    }

  #sql_table_name: "LCS".{% parameter environment %}."ADF";;

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

  dimension: activity {
    type: string
    sql: ${TABLE}."ACTIVITY" ;;
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
    type: string
    sql: ${TABLE}."CGI" ;;
  }

  dimension: checkpoint_id {
    type: string
    sql: ${TABLE}."CHECKPOINT_ID" ;;
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

  dimension: description {
    type: string
    sql: ${TABLE}."DESCRIPTION" ;;
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

  dimension: role {
    type: string
    sql: ${TABLE}."ROLE" ;;
  }

  dimension: settings {
    type: string
    sql: ${TABLE}."SETTINGS" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TENANT_ID" ;;
  }

  dimension: text_following_activity {
    type: string
    sql: ${TABLE}."TEXT_FOLLOWING_ACTIVITY" ;;
  }

  dimension: text_preceding_activity {
    type: string
    sql: ${TABLE}."TEXT_PRECEDING_ACTIVITY" ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}."TITLE" ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}."TYPE" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
