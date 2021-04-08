include: "/views/explore_level_parameters.view"
include: "sdf_r.base"
explore: sdf_r {
  hidden:yes
  from: sdf_r
  view_name: sdf_r

  join: explore_level_parameters {}
}