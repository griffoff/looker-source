include: "/views/explore_level_parameters.view"
include: "cdf.base"
explore: cdf {
  hidden:yes
  from: cdf
  view_name: cdf

  join: explore_level_parameters {}
}