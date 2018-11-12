view: calendar {
  derived_table: {
    sql:
select date::date as cal_date,
       extract('isodow' from date) as dow,
       to_char(date, 'dy') as day,
       extract('isoyear' from date) as "iso year",
       extract('week' from date) as week,
       extract('day' from
               (date + interval '2 month - 1 day')
              )
        as feb,
       extract('year' from date) as year,
       extract('day' from
               (date + interval '2 month - 1 day')
              ) = 29
       as leap
  from generate_series(date '2015-01-01',
                       CURRENT_DATE,
                       interval '1 day')
       as t(date)
       ;;
  }

  dimension_group: cal_date {
    type: time
    timeframes: [
      year,
      month,
      date,
      day_of_week,
      month_num,
      day_of_week_index,
      quarter,
      quarter_of_year,
      week,
      week_of_year
    ]
    sql: ${TABLE}.cal_date ;;
  }
}
