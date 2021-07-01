include: "/views/common_includes.lkml"
include: "cdf.base"

explore: cdf {
  extends: [root]

  join: cdf {
    sql_on: TRUE ;;
    relationship: one_to_many
  }

  join: explore_level_parameters {}
}

view: +cdf {
  label: "CDF"
  dimension: settings_cgi {
    type: string
    # TODO: this should be a flatten, in case there are multiple references
    sql: ${settings_reference_group}:settings[0]:referenceId ;;
  }
}
