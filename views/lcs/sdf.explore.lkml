include: "sdf.view"
include: "sdf_flattened.view"
explore: +sdf {
  extends: [sdf_flattened]
  join: sdf_flattened {
    sql_on: ${sdf.cgi} = ${sdf_flattened.cgi}
        AND ${sdf.checkpoint_id} = ${sdf_flattened.checkpoint_id}
        ;;
  }
}
