include: "/views/common_includes.lkml"
include: "sdf_r.base"
explore: sdf_r {
  hidden:yes
  from: root
  view_name: root

  join: sdf_r {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
