# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '12h', :first_in => 0 do |job|
  send_event('welcome', {text: "Take a look around" })
end
