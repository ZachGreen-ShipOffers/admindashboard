require 'pg'
require 'sequel'
require 'awesome_print'

SCHEDULER.every '1h', :first_in => 0 do |job|
  orders = DB["SELECT * FROM ship_station_orders where ship_date = ?", Date.today]
  count = orders.count
  send_event('shipments', { count: count })
end
