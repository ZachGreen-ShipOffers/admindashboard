# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '12h', :first_in => 0 do |job|
  items = []
  DB["SELECT (SELECT name FROM client_companies where ship_station_stores.client_company_id = client_companies.id) as name, count(*) as amount FROM ship_station_shipments
    INNER JOIN ship_station_orders ON ship_station_shipments.ship_station_order_id = ship_station_orders.id
    INNER JOIN ship_station_stores ON ship_station_orders.ship_station_store_id = ship_station_stores.id
    WHERE ship_station_shipments.ship_date = ?
    GROUP BY ship_station_stores.client_company_id
    ORDER BY amount desc LIMIT 10", Date.today].map do |x|
    items << x
  end
  send_event('most_shipments', {items: items})
end
