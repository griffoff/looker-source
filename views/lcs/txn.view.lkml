include: "/views/explore_level_parameters.view"
include: "txn.base"
explore: txn {
  hidden:yes
  from: txn
  view_name: txn

  join: explore_level_parameters {}
}