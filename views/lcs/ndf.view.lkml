include: "/views/common_includes.lkml"
include: "ndf.base"
explore: ndf {
  hidden:yes
  from: root
  view_name: root

  join: ndf {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
