view: symphonyrm_test_sql_step {
  derived_table: {
    # datagroup_trigger: the_look_leticia_default_datagroup
    sql_trigger_value: SELECT CURDATE() ;;
    create_process: {
      sql_step:
      CREATE TABLE ${SQL_TABLE_NAME}
      (customer_id int(11),
      lifetime_orders int(11)) ;;
      sql_step:
      INSERT INTO ${SQL_TABLE_NAME}
      (customer_id,
      lifetime_orders)
      SELECT customer_id, COUNT(*)
      AS lifetime_orders
      FROM order
      GROUP BY customer_id ;;
    }
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders  ;;
  }

}
