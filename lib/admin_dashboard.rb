require 'pg'
require 'sequel'

class AdminDashboard
  DB = Sequel.connect('postgres://postgres:QmDfZx5782@127.0.0.1:5432/etrackerlive_development')

  def shipments(from, to, cpny)
    shipments = DB["SELECT * FROM ship_station_shipments where ship_date between ? and ?", from, to]
    send_event('shipments', {count: shipments.count })
  end

  def orders(from, to, cpny)
    orders = DB["SELECT * FROM ship_station_orders where ship_date between ? and ?", from, to]
    send_event('orders', {count: orders.count })
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

# DB = Sequel.connect('postgres://shipoffersdev:d6a96rPc0Q034421PARr@shipoffers-dev.cfhz9xwrbhxg.us-west-2.rds.amazonaws.com:5432/etracker_dev')
