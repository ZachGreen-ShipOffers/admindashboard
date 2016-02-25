require 'pg'
require 'sequel'

class AdminDashboard
  # DB = Sequel.connect('postgres://postgres:QmDfZx5782@127.0.0.1:5432/etrackerlive_development')

  def shipments(from, to, cpny)
    shipments = DB["SELECT * FROM ship_station_shipments where ship_date between ? and ?", from, to]
    send_event('shipments', {count: shipments.count })
  end

  def orders(from, to, cpny)
    orders = DB["SELECT * FROM ship_station_orders where ship_date between ? and ?", from, to]
    send_event('orders', {count: orders.count })
  end

  def most_shipped(from, to, cpny)
    items = []
    DB["SELECT name, count(*) as count
        FROM ship_station_shipment_items where ship_station_shipment_id in
        (SELECT id from ship_station_shipments where ship_date between '2016-02-22' and '2016-02-22')
        group by name order by count desc LIMIT 10"].map do |x|
      items << x
    end
    send_event('most_shipped', {items: items })
  end

  def most_shipments(from, to, cpny)
    items = []
    DB["SELECT (SELECT name FROM client_companies where ship_station_stores.client_company_id = client_companies.id) as name, count(*) as amount FROM ship_station_shipments
      INNER JOIN ship_station_orders ON ship_station_shipments.ship_station_order_id = ship_station_orders.id
      INNER JOIN ship_station_stores ON ship_station_orders.ship_station_store_id = ship_station_stores.id
      WHERE ship_station_shipments.ship_date between ? and ?
      GROUP BY ship_station_stores.client_company_id
      ORDER BY amount desc LIMIT 10", from, to].map do |x|
      items << x
    end
    send_event('most_shipments', {items: items })
  end

  def welcome(from, to, cpny)
    text = "Results for #{from} through #{to}"
    if !cpny.empty?
      text =+ " for #{cpny}"
    end
    text += "."
    send_event('welcome', {text: text })
  end
end
