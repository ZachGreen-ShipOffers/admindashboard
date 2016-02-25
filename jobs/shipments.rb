require 'pg'
require 'sequel'
require 'awesome_print'
# DB = Sequel.connect('postgres://postgres:QmDfZx5782@127.0.0.1:5432/etrackerlive_development')
D = Sequel.connect('postgres://shipoffersdev:d6a96rPc0Q034421PARr@shipoffers-dev.cfhz9xwrbhxg.us-west-2.rds.amazonaws.com:5432/etracker_dev')

SCHEDULER.every '1h', :first_in => 0 do |job|
  shipments = D[:ship_station_shipments]
  count = shipments.count
  send_event('shipments', { count: count })
end
