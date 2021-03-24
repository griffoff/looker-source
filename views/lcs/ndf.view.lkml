include: "/views/environment.view"
include: "./ndf_references.view"

explore: ndf {
  from: ndf
  view_name: ndf

  hidden:yes

  join: ndf_references {
    sql_on: ${ndf.cgi} = ${ndf_references.cgi} ;;
    relationship: many_to_many
  }

}

view: ndf {
  extends: [environment]
  sql_table_name: "LCS".{% parameter environment %}."NDF"
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
    type: string
    sql: ${TABLE}."CGI" ;;
  }

  dimension: checkpoint_id {
    type: string
    sql: ${TABLE}."CHECKPOINT_ID" ;;
  }

  dimension: children {
    type: string
    sql: ${TABLE}."CHILDREN" ;;
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

  dimension: display_title {
    type: string
    sql: ${TABLE}."DISPLAY_TITLE" ;;
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

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TENANT_ID" ;;
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
