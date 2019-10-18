- view: cohort_stats_users_byday

  derived_table:
    sql: |
      SELECT * FROM DEEP_THOUGHT.AGG.COHORT_STATS_USERS_BYDAY
        
    #sql_trigger_value: select DATE_PART('day', CURRENT_TIMESTAMP) 
    sql_trigger_value: SELECT FLOOR((EXTRACT(epoch from current_timestamp()) - 60*60*15)/(60*60*24))
    
  fields:
  
  - dimension: game_id
    sql: ${TABLE}.game_id
    
  - dimension: env
    sql: ${TABLE}.env
    
  - dimension: platform
    sql: ${TABLE}.platform
    
  - dimension: source_type
    sql: ${TABLE}.source_type
    
  - dimension: publisher_name
    sql: ${TABLE}.publisher_name
  
  - dimension: country_id
    sql: ${TABLE}.country_id
  
  - dimension: country_tier
    label: 'Country Tier'
    type: string
    sql_case: 
      "US" : ${country_id} in ('US') 
      "APAC" : ${country_id} in ('JP','KR','HK','MY','PH','SG','TW','ID','VN','CN') 
      "West" : ${country_id} in ('GB','DE','FR','CA','AU','NL','SE','DK','CH','NO','FI','BE','IT','ES') 
      "ROW": true 
      
  - dimension: fb_adset_id
    sql: ${TABLE}.fb_adset_id
  
  - dimension: fb_adset_name
    sql: ${TABLE}.fb_adset_name
  
  - dimension_group: dt_pst
    type: time
    timeframes: [date, day_of_week, week, month, quarter, year]
    
  - dimension: is_today
    type: number
    sql: ${TABLE}.is_today
#     hidden: true
    
  - dimension: is_yesterday
    type: number
    sql: ${TABLE}.is_yesterday
    hidden: true
    
  - dimension: installs
    type: number
    sql: ${TABLE}.installs_total
    value_format_name: decimal_0
    hidden: true
  
  - dimension: actives
    type: number
    sql: ${TABLE}.actives
    value_format_name: decimal_0
    hidden: true
  
  - dimension: installs_paid
    type: number
    sql: ${TABLE}.installs_paid
    value_format_name: decimal_0
    hidden: true
    
  - dimension: installs_organic
    type: number
    sql: ${TABLE}.installs_organic
    value_format_name: decimal_0
    hidden: true
    
  - dimension: device_installs
    type: number
    sql: ${TABLE}.device_installs_total
    value_format_name: decimal_0
    hidden: true
 
  - dimension: device_installs_paid
    type: number
    sql: ${TABLE}.device_installs_paid
    value_format_name: decimal_0
    hidden: true
    
  - dimension: spend
    type: number
    html: |
      <p align="left">{{ rendered_value }} </p>
    sql: ${ua_spend.spend}
    value_format_name: usd
    hidden: true
    
  - dimension: revenue_grss
    type: number
    sql: ${TABLE}.revenue_total_grss
    value_format_name: usd
    hidden: true

  - dimension: revenue_ctd
    type: number
    sql: ${TABLE}.revenue_total_ctd
    value_format_name: usd
    hidden: true
 
  - dimension: revenue_net
    type: number
    sql: ${TABLE}.revenue_total_grss * 0.68
    value_format_name: usd
    hidden: true
    
  - dimension: monetizers
    type: number
    label: "Monetizers"
    sql: ${TABLE}.monetizers
    
    
  - dimension: release_version
    label: 'Release Version'
    type: string
    sql_case: 
      "2.7": ${dt_pst_date} >= '2016-08-12' AND ${dt_pst_date} <= '2016-09-01'
      "2.8": ${dt_pst_date} >= '2016-09-02' AND ${dt_pst_date} <= '2016-09-20'
      "2.8.1": ${dt_pst_date} >= '2016-09-21' AND ${dt_pst_date} <= '2016-10-06'
      "2.9": ${dt_pst_date} >= '2016-10-07' AND ${dt_pst_date} <= '2016-11-13'
      "2.10": ${dt_pst_date} >= '2016-11-15'
      "Other": true    

  ### session 2: measures
  
  - measure: installs_total
    type: sum
    html: |
      <p align="left">{{ rendered_value }} </p>
    label: "Total Installs"
    sql: ${installs}

  - measure: installs_paid_total
    type: sum
    html: |
      <p align="left">{{ rendered_value }} </p>
    label: "Paid Installs"
    sql: ${installs_paid}    
    
  - measure: installs_organic_total
    html: |
      <p align="left">{{ rendered_value }} </p>
    type: sum
    label: "Organic Installs"
    sql: ${installs_organic}  
    
  - measure: device_installs_total
    type: sum
    label: "Total New Devices"
    sql: ${device_installs}

  - measure: device_installs_paid_total
    type: sum
    label: "Paid New Devices"
    sql: ${device_installs_paid}  
    
  - measure: spend_total_raw
    type: sum
    sql: ${spend}
    #label: "Spend"
    value_format_name: usd_0
    
  - measure: is_really_today
    type: max
    sql: ${is_today}
    hidden: true
    
  - measure: is_really_yesterday
    type: max
    sql: ${is_yesterday}
    hidden: true
    
  - measure: spend_total
    type: number
    html: |
      <p align="left">{{ rendered_value }} </p>
    sql: ${spend_total_raw}*${is_really_today}
    label: "Spend"
    value_format_name: usd_0
    
  - measure: total_actives_raw
    type: sum
    label: "Total Active Users"
    sql: ${actives}
  
  - measure: total_actives
    type: number
    html: |
      <p align="left">{{ rendered_value }} </p>
    sql: ${total_actives_raw}*${is_really_today}
    label: "Active Users"
    
  - measure: ecpi_ave
    type: number
    html: |
      <p align="left">{{ rendered_value }} </p>
    sql: ${spend_total}/NULLIF(${installs_total},0)
    label: "eCPI"
    value_format_name: usd

  - measure: cpi_ave
    type: number
    html: |
      <p align="left">{{ rendered_value }} </p>
    sql: ${spend_total}/NULLIF(${installs_paid_total},0)
    label: "CPI"
    value_format_name: usd
    
  - measure: revenue_total
    type: sum
    html: |
      <p align="left">{{ rendered_value }} </p>
    sql: ${revenue_grss}
    label: "Revenue"
    value_format_name: usd_0
    
  - measure: revenue_ctd_total
    type: sum
    sql: ${revenue_ctd}
    html: |
      <p align="left">{{ rendered_value }} </p>
    label: "Contributed Revenue"
    value_format_name: usd_0
  
  - measure: revenue_net_total
    type: sum
    html: |
      <p align="left">{{ rendered_value }} </p>
    sql: ${revenue_net}
    label: "Net Revenue"
    value_format_name: usd_0
    
  - measure: total_monetizers
    type: sum
    html: |
      <p align="left">{{ rendered_value }} </p>
    sql: ${monetizers}
    label: "Monetizers"
    
#   - measure: mcvr
#     type: number
#     html: |
#       <p align="left">{{ rendered_value }} </p>
#     sql: NULLIF(${total_monetizers},0) / NULLIF(${installs_total},0)
#     label: "mCVR"
#     value_format_name: percent_1
#     
#   - measure: arppu
#     type: number
#     html: |
#       <p align="left">{{ rendered_value }} </p>
#     sql: ${revenue_total} / NULLIF(${total_monetizers},0)
#     label: "ARPPU"
#     value_format_name: usd_0
    
#   - measure: arpu_ave
#     type: number
#     html: |
#       <p align="left">{{ rendered_value }} </p>
#     sql: ${revenue_total} / NULLIF(${installs_total},0)
#     label: "ARPU"
#     value_format_name: usd
    
#   - measure: retention
#     type: number
#     html: |
#       <p align="left">{{ rendered_value }} </p>
#     sql: (${total_actives} / NULLIF(${installs_total},0))*${is_really_yesterday}
#     label: "Retention"
#     value_format_name: percent_1
#     
#   - measure: yield
#     type: number
#     html: |
#       <p align="left">{{ rendered_value }} </p>
#     sql: NULLIF(${revenue_net_total},0) / NULLIF(${spend_total},0)
#     label: "Yield"
#     value_format_name: percent_2
#     hidden: true
#     
#   - measure: lift
#     type: number
#     html: |
#       <p align="left">{{ rendered_value }} </p>
#     sql: NULLIF(${installs_organic_total},0) / NULLIF(${installs_paid_total},0)
#     label: "Organic Lift"
#     value_format_name: decimal_2
    
#   - measure: spend_total
#     type: number
#     html: |
#       <p align="left">{{ rendered_value }} </p>
#     sql: ${spend_total_raw}*${is_really_today}
#     label: "Spend"
#     value_format_name: usd_0
#   
    
