require 'sinatra'
require 'httparty'
require 'pg'
require 'sequel'
require 'awesome_print'
DB = Sequel.connect('postgres://shipoffersdev:d6a96rPc0Q034421PARr@shipoffers-dev.cfhz9xwrbhxg.us-west-2.rds.amazonaws.com:5432/etracker_dev')

get '/res' do
  'Get route /res'
end

post '/res' do
  from = Date.strptime(params['from'], '%m/%d/%Y')
  to = Date.strptime(params['to'], '%m/%d/%Y')
  ap "#{from} => #{to}"
  shipments = DB["SELECT * FROM ship_station_shipments where ship_date between ? and ?", from, to]
  ap shipments.count
  send_event('shipments', {count: shipments.count })
  params
end
