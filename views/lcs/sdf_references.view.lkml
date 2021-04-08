include: "/views/explore_level_parameters.view"
include: "sdf_references.base"
explore: sdf_references {
  hidden:yes
  from: sdf_references
  view_name: sdf_references

  join: explore_level_parameters {}
}