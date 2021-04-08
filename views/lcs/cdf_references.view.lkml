include: "/views/explore_level_parameters.view"
include: "cdf_references.base"
explore: cdf_references {
  hidden:yes
  from: cdf_references
  view_name: cdf_references

  join: explore_level_parameters {}
}