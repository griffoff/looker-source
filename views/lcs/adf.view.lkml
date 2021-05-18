include: "/views/common_includes.lkml"
include: "adf.base"
explore: adf {
  hidden:yes
  from: root
  view_name: root

  join: adf {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
