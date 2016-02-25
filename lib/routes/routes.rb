require 'sinatra'
require 'awesome_print'
require '/home/zach/Files/admindashboard/lib/admin_dashboard.rb'

get '/res' do
  'Get route /res'
end

post '/res' do
  a = AdminDashboard.new
  from = Date.strptime(params['from'], '%m/%d/%Y')
  to = Date.strptime(params['to'], '%m/%d/%Y')

  params['ids'].each do |id|
    ap id
    a.send(id, from, to, cpny='') if AdminDashboard.method_defined? id.to_sym
  end
  params
end
