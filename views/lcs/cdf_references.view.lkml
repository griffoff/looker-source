include: "/views/common_includes.lkml"
include: "cdf_references.base"
explore: cdf_references {
  hidden:yes
  from: root
  view_name: root

  join: cdf_references {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
