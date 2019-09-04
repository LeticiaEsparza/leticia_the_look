 - dashboard: dashboard_deletion_test
   title: Dashboard Deletion Test
   layout: tile
   tile_size: 100
   elements:
    - name: add_a_unique_name_1567636326
      title: Untitled Visualization
      model: LookML_Dashboard_Deletion_Test
      explore: order_items
      type: table
      fields: [orders.id, products.count]
      sorts: [products.count desc]
      limit: 5
      query_timezone: UTC
