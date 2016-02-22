require 'pg'
require 'sequel'
require 'awesome_print'
DB = Sequel.connect('postgres://postgres:QmDfZx5782@127.0.0.1:5432/etrackerlive_development')

SCHEDULER.every '1h', :first_in => 0 do |job|
  shipments = DB[:ship_station_shipments]
  count = shipments.count
  send_event('shipments', { count: count })
end
