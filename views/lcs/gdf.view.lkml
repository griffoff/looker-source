include: "/views/explore_level_parameters.view"
include: "gdf.base"
explore: gdf {
  hidden:yes
  from: gdf
  view_name: gdf

  join: explore_level_parameters {}
}