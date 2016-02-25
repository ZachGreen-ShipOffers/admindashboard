require '/home/zach/Files/admindashboard/lib/admin_dashboard.rb'


# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '12h', :first_in => 0 do |job|
  items = []
  DB["SELECT name, count(*) as count
      FROM ship_station_shipment_items where ship_station_shipment_id in
      (SELECT id from ship_station_shipments where ship_date = ?)
      group by name order by count desc LIMIT 10", Date.today].map do |x|
    items << x
  end
  send_event('most_shipped', {items: items})
end
