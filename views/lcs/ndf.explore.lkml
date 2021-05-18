include: "ndf.view"
include: "ndf_references.view"

explore: +ndf {

  join: ndf_references {
    sql_on: ${ndf.cgi} = ${ndf_references.cgi} ;;
    relationship: many_to_many
  }

}
