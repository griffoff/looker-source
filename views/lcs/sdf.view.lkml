include: "/views/explore_level_parameters.view"
include: "sdf.base"
explore: sdf {
  hidden:yes
  from: sdf
  view_name: sdf

  join: explore_level_parameters {}
}