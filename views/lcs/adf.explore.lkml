include: "adf.view"
include: "adf_references.view"

explore: +adf {

  join: adf_references {
    sql_on: ${adf.cgi} = ${adf_references.cgi} and ${adf.checkpoint_id} = ${adf_references.checkpoint_id} ;;
    relationship: one_to_many
  }

  join: referencer {
    from: adf
    sql_on: ${adf_references.referencer_cgi} = ${referencer.cgi} and ${adf_references.referencer_retrieval_id} = ${referencer.retrieval_id} ;;
    relationship: many_to_one
  }
}
