include: "/views/common_includes.lkml"
include: "sdf.base"
explore: sdf {
  hidden:yes
  from: root
  view_name: root

  join: sdf {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}

view: +sdf {
  label: "SDF"

}
