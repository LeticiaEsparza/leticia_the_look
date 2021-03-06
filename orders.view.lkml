view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      fiscal_quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  # filter: status_filter {
  #   type: string
  #   suggestable: yes
  # }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    action: {
      label: "Label to Appear in Action Menu"
      url: "https://example.com/posts"
      icon_url: "https://looker.com/favicon.ico"
      form_url: "https://example.com/ping/{{ value }}/form.json"
      param: {
        name: "name string"
        value: "value string"
      }
      form_param: {
        name: "name string"
        type:  string
        label: "possibly-localized-string"
        default: "string"
      }
    }
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure : sum_total_cost {
    label: "Prêmio Total"
    type: sum_distinct
    sql: CASE WHEN ${status} = 'complete' THEN ${order_items.sale_price} ELSE 0 END ;;
    sql_distinct_key: ${id} || ${order_items.id} ;;
    filters: {
      field: order_items.inventory_item_id_voolean
      value: "yes"
    }
#     value_format_name: brl
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }
}
