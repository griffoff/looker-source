view: sdf_references {
  sql_table_name: "LCS".{% parameter explore_level_parameters.schema_name %}."SDF_REFERENCES"
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

  dimension: cgi {
    type: string
    sql: ${TABLE}."CGI" ;;
  }

  dimension: checkpoint_id {
    type: string
    sql: ${TABLE}."CHECKPOINT_ID" ;;
  }

  dimension: file_type {
    type: string
    sql: ${TABLE}."FILE_TYPE" ;;
  }

  dimension: referencer_cgi {
    type: string
    sql: ${TABLE}."REFERENCER_CGI" ;;
  }

  dimension: referencer_retrieval_id {
    type: string
    sql: ${TABLE}."REFERENCER_RETRIEVAL_ID" ;;
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
