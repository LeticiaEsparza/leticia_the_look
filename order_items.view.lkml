view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: inventory_item_id_voolean {
    type: yesno
    sql: ${inventory_item_id} > 0 ;;
  }

  measure : sum_total_cost {
    label: "Prêmio Total"
    type: sum_distinct
    sql: ${sale_price};;
    sql_distinct_key: ${id};;
#     filters: {
#       field: order_items.inventory_item_id_voolean
#       value: "yes"
#     }
#     value_format_name: brl
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
#     value_format_name: gbp
  }

  measure: count_filtered {
    type: count
#     filters: {
#       field: products.category
#       value: "Pants"
#     }
#     filters: {
#       field: products.brand
#       value: "Calvin Klein, Calvin Klein Jeans"
#     }
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
