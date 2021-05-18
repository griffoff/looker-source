include: "/views/common_includes.lkml"
include: "gdf_references.base"
explore: gdf_references {
 hidden:yes
  from: root
  view_name: root

  join: gdf_references {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
