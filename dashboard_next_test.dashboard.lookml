- dashboard: dashboardsnext_test
  title: Dashboards-Next Test
  layout: newspaper
  elements:
  - title: Items Ordered - Last 6 Months
    name: Items Ordered - Last 6 Months
    model: thelook
    explore: order_items
    type: single_value
    fields: [order_items.count]
    filters:
      orders.created_date: 6 months
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Items Ordered - Last 6 Months
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    row: 0
    col: 0
    width: 8
    height: 6
  - title: Average Order Size - Last Year
    name: Average Order Size - Last Year
    model: thelook
    explore: order_items
    type: table
    fields: [order_items.avg_order_price, orders.created_month]
    fill_fields: [orders.created_month]
    filters:
      orders.created_date: 12 months
    sorts: [order_items.avg_order_price desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Items Ordered - Last 6 Months
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 0
    col: 8
    width: 8
    height: 6
  - title: Median Item Price - Last Year
    name: Median Item Price - Last Year
    model: thelook
    explore: order_items
    type: looker_column
    fields: [orders.created_month, order_items.median_item_price]
    fill_fields: [orders.created_month]
    filters:
      orders.created_date: 12 months
    sorts: [orders.created_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Items Ordered - Last 6 Months
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 0
    col: 16
    width: 8
    height: 6
  - title: Total Profit by State - Last 12 Months
    name: Total Profit by State - Last 12 Months
    model: thelook
    explore: order_items
    type: looker_geo_choropleth
    fields: [order_items.total_profit, users.state]
    filters:
      orders.created_date: 12 months
    sorts: [order_items.total_profit desc]
    limit: 500
    query_timezone: America/Los_Angeles
    map: usa
    map_projection: ''
    outer_border_color: purple
    inner_border_color: yellow
    outer_border_width: 3
    inner_border_width: 1
    show_view_names: false
    colors: [green]
    empty_color: black
    quantize_colors: false
    map_plot_mode: automagic_heatmap
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_latitude: 37.92443025672885
    map_longitude: -94.82917785644533
    map_zoom: 4
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Items Ordered - Last 6 Months
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 6
    col: 0
    width: 8
    height: 6
