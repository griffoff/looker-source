include: "/views/common_includes.lkml"
include: "cars_references.base"
explore: cars_references {
  hidden:yes
  from: root
  view_name: root

  join: cars_references {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
