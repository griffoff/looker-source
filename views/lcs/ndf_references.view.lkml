include: "/views/explore_level_parameters.view"
include: "ndf_references.base"
explore: ndf_references {
  hidden:yes
  from: ndf_references
  view_name: ndf_references

  join: explore_level_parameters {}
}