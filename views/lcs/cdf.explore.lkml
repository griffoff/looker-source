include: "cdf.view"
include: "sdf.explore"
include: "//cengage_unlimited/views/cu_user_analysis/course_info.explore"

explore: +cdf {
  extends: [sdf, course_info]

  join: course_info {
    sql_on: ${cdf.cgi} = ${course_info.course_cgi} ;;
    relationship: one_to_one
  }
  join: sdf {
    sql_on: ${cdf.settings_cgi} = ${sdf.cgi}
        and ${cdf.checkpoint_id} = ${sdf.checkpoint_id};;
        relationship: many_to_one
  }
}
