include: "/views/explore_level_parameters.view"
include: "ndf.base"
explore: ndf {
  hidden:yes
  from: ndf
  view_name: ndf

  join: explore_level_parameters {}
}