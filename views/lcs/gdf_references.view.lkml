include: "/views/explore_level_parameters.view"
include: "gdf_references.base"
explore: gdf_references {
  hidden:yes
  from: gdf_references
  view_name: gdf_references

  join: explore_level_parameters {}
}