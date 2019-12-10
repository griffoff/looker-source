view: latest_take {
  view_label: "Activity Outcome Detail"
  derived_table: {
    sql: SELECT activity_outcome_id, max(id) as aod_id
          FROM ${activity_outcome_detail.SQL_TABLE_NAME}
          GROUP BY 1;;
    }
    dimension: activity_outcome_id {
      primary_key: yes
      hidden: yes
    }
    dimension: aod_id {
     hidden: yes
    }
    dimension: is_latest_take {
      type: yesno
      sql: ${aod_id} IS NOT NULL ;;
    }
}


view: activity_outcome_detail {
  view_label: "Activity Outcome Detail"
  sql_table_name: STG_MINDTAP.ACTIVITY_OUTCOME_DETAIL ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: activity_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ACTIVITY_ID ;;
  }

  dimension: activity_outcome_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ACTIVITY_OUTCOME_ID ;;
  }

  dimension: created_by {
    type: string
    sql: ${TABLE}.CREATED_BY ;;
  }

  dimension: created_date {
    type: string
    sql: ${TABLE}.CREATED_DATE ;;
  }

  dimension: is_auto_submitted {
    type: string
    sql: ${TABLE}.IS_AUTO_SUBMITTED ;;
  }

  dimension: is_deleted {
    type: string
    sql: ${TABLE}.IS_DELETED ;;
  }

  dimension: is_graded {
    type: string
    sql: ${TABLE}.IS_GRADED ;;
  }

  dimension: is_student_take {
    type: string
    sql: ${TABLE}.IS_STUDENT_TAKE ;;
  }

  dimension: last_autosubmit_date {
    type: string
    sql: ${TABLE}.LAST_AUTOSUBMIT_DATE ;;
  }

  dimension: last_modified_by {
    type: string
    sql: ${TABLE}.LAST_MODIFIED_BY ;;
  }

  dimension_group: last_modified_date {
    group_label: "Last Modified"
    type: time
    timeframes: [raw, minute, hour, day_of_week, date, month, month_name, year]
    sql: TO_TIMESTAMP(${TABLE}.LAST_MODIFIED_DATE, 3) ;;
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
  }

  dimension: points_earned {
    type: number
    sql: ${TABLE}.POINTS_EARNED ;;
  }

  dimension: points_possible {
    type: number
    sql: ${TABLE}.POINTS_POSSIBLE ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.SCORE ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS ;;
  }

  dimension_group: take_end_time {
    group_label: "Take End"
    type: time
    timeframes: [raw, minute, hour, day_of_week, date, month, month_name, year]
    sql: to_timestamp(${TABLE}.TAKE_END_TIME, 3) ;;
  }

  dimension_group: attempt_submitted {
    type: time
    datatype: epoch
    timeframes: [time, date]
    sql: ${TABLE}.TAKE_END_TIME / 1000 ;;
  }

  measure: latest_attempt {
    type: date
    sql: MAX(${attempt_submitted_time}) ;;
  }

  dimension: take_id {
    type: string
    sql: ${TABLE}.TAKE_ID ;;
  }

  dimension: take_number {
    type: string
    sql: ${TABLE}.TAKE_NUMBER ;;
  }

  dimension: take_start_time {
    type: string
    sql: ${TABLE}.TAKE_START_TIME ;;
  }

  dimension_group: attempt_started {
    type: time
    datatype: epoch
    timeframes: [time, date]
    sql: ${TABLE}.TAKE_START_TIME / 1000 ;;
  }

  dimension: user_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.VERSION ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: cycle_time_mins {
    type: number
    sql: datediff(minute, ${take_end_time_raw}, ${activity_outcome.last_modified_date_raw});;
    hidden: yes
  }

  measure: cycle_time_max_hrs {
    group_label: "Cycle time"
    type: number
    sql: MAX(${cycle_time_mins}) / 60;;
    value_format_name: decimal_1
  }

  measure: cycle_time_min_hrs {
    group_label: "Cycle time"
    type: number
    sql: MIN(${cycle_time_mins}) / 60;;
    value_format_name: decimal_1
  }

  measure: cycle_time_avg_hrs {
    group_label: "Cycle time"
    type: number
    sql: AVG(${cycle_time_mins}) / 60;;
    value_format_name: decimal_1
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      activity_outcome.id,
      activity.app_activity_id,
      user.id,
      user.fname,
      user.lname,
      user.source_name,
      user.username
    ]
  }
}
