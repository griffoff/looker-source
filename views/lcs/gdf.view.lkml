include: "/views/common_includes.lkml"
include: "gdf.base"
explore: gdf {
    hidden:yes
  from: root
  view_name: root

  join: gdf {
    sql_on: TRUE ;;
    relationship: one_to_many
  }
  join: explore_level_parameters {}
}
