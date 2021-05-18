include: "/views/common_includes.lkml"
include: "txn.base"
explore: txn {
  hidden:yes
  from: root
  view_name: root

  join: txn {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}
