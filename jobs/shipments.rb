require 'pg'
require 'sequel'
require 'awesome_print'

SCHEDULER.every '1h', :first_in => 0 do |job|
  shipments = DB["SELECT * FROM ship_station_shipments where ship_date = ?", Date.today]
  count = shipments.count
  send_event('shipments', { count: count })
end
