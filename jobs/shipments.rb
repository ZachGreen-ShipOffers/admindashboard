require 'pg'
require 'awesome_print'
info = {
  host: 'localhost',
  dbname: 'etrackerlive_development',
  user: 'postgres',
  password: 'QmDfZx5782',

}
conn = PG.connect(info)
SCHEDULER.every '1h', :first_in => 0 do |job|
  res = conn.exec("SELECT count(id) from ship_station_shipments where ship_date = '2016-02-17'")
  count = res[0]['count']
  send_event('shipments', { count: count })
end
