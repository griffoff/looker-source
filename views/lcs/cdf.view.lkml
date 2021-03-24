include: "/views/environment.view"
explore: cdf {hidden:yes}

view: cdf {
  extends: [environment]
  sql_table_name: "LCS".{% parameter environment %}."CDF"
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

  dimension: course_metadata {
    type: string
    sql: ${TABLE}."COURSE_METADATA" ;;
  }

  dimension: course_provider_group {
    type: string
    sql: ${TABLE}."COURSE_PROVIDER_GROUP" ;;
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

  dimension: gradebook_reference_group {
    type: string
    sql: ${TABLE}."GRADEBOOK_REFERENCE_GROUP" ;;
  }

  dimension: graph_reference_group {
    type: string
    sql: ${TABLE}."GRAPH_REFERENCE_GROUP" ;;
  }

  dimension: navigation_reference_group {
    type: string
    sql: ${TABLE}."NAVIGATION_REFERENCE_GROUP" ;;
  }

  dimension: product_metadata {
    type: string
    sql: ${TABLE}."PRODUCT_METADATA" ;;
  }

  dimension: resources_reference_group {
    type: string
    sql: ${TABLE}."RESOURCES_REFERENCE_GROUP" ;;
  }

  dimension: retrieval_id {
    type: string
    sql: ${TABLE}."RETRIEVAL_ID" ;;
  }

  dimension: revision_id {
    type: string
    sql: ${TABLE}."REVISION_ID" ;;
  }

  dimension: settings_reference_group {
    type: string
    sql: ${TABLE}."SETTINGS_REFERENCE_GROUP" ;;
  }

  dimension: tenant_id {
    type: string
    sql: ${TABLE}."TENANT_ID" ;;
  }

  dimension: ux_features_reference_group {
    type: string
    sql: ${TABLE}."UX_FEATURES_REFERENCE_GROUP" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
