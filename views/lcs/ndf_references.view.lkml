include: "/views/common_includes.lkml"
include: "ndf_references.base"
explore: ndf_references {
  hidden:yes
  from: root
  view_name: root

  join: ndf_references {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
