include: "/views/common_includes.lkml"
include: "sdf_references.base"
explore: sdf_references {
  hidden:yes
  from: root
  view_name: root

  join: sdf_references {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
