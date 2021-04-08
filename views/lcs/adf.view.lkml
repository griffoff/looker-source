include: "/views/explore_level_parameters.view"
include: "adf.base"
explore: adf {
  hidden:yes
  from: adf
  view_name: adf

  join: explore_level_parameters {}
}
