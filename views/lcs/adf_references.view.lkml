include: "/views/common_includes.lkml"
include: "adf_references.base"
explore: adf_references {
  hidden:yes
  from: root
  view_name: root

  join: adf_references {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
