include: "/views/explore_level_parameters.view"
include: "adf_references.base"
explore: adf_references {
  hidden:yes
  from: adf_references
  view_name: adf_references

  join: explore_level_parameters {}
}