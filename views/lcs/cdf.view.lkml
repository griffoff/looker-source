include: "/views/common_includes.lkml"
include: "cdf.base"
explore: cdf {
  hidden:yes
  from: root
  view_name: root

  join: cdf {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
