include: "/views/common_includes.lkml"
include: "cars.base"
explore: cars {
 hidden:yes
  from: root
  view_name: root

  join: cars {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
