require 'json'
include LogUtils

# keep start time of the seed 
@batch = Time.now

# 1. clean all the tables
p 'Clean DB...'
Confirmation.delete_all
Request.delete_all
Delay.delete_all

# 2. insert the default delays
p 'Insert the default Delays...'
file = File.join(File.dirname(__FILE__), "./delays.json")
delays = JSON.parse(File.read(file))

delays.each do |delay|
  p "  Inserting #{delay["name"]}..."
  Delay.create(
    name: delay["name"],
    value: delay["value"],
    description: delay["desc"])
end

# 3. store delays
conf_interval = Delay.find_by(name: 'req_reconfirmation').value
first_conf = Delay.find_by(name: 'confirmation_validity').value
reconf = Delay.find_by(name: 'reconfirmation_validity').value

# 3. insert requests/confirmations
p 'Insert the requests and confirmations...'
file = File.join(File.dirname(__FILE__), "./cases.json")
requests = JSON.parse(File.read(file))

def insert_conf(p_req_id, p_creation_date, p_delay)
  new_conf = Confirmation.create(
    request_id: p_req_id,
    validation_key: SecureRandom.hex(16),
    reply_delay: p_delay,
    created_at: p_creation_date,
    updated_at: p_creation_date
  )
  new_conf.update(replied_at: new_conf.created_at + 30.minutes) if @batch.to_date - (p_delay + 2) > new_conf.created_at.to_date
  add_log(p_req_id, "Mail sent", "S")
end

requests.each do |request|
  p "  Inserting #{request["name"]} (#{request["bio"]})..."
  creation_date = @batch + request["m"].month + request["d"].day + request["h"].hour
  new_request = Request.create(
    name: request["name"],
    email: "#{request["name"]}@nains.com",
    phone: '0601020304',
    bio: request["bio"],
    confirmed: request["confirmed"],
    created_at: creation_date,
    updated_at: creation_date
  )
  new_request.update(accepted_at: creation_date + 1.hour) if request["accepted"]
  add_log(new_request.id, "New request added", "S")

  p "    Inserting the first confirmation..."
  insert_conf(new_request.id, creation_date, first_conf)

  p "    Inserting the addtionnal confirmations, if needed..."
  unless request["accepted"]
    months = request["m"]
    days = request["d"]
    hours = request["h"]
    while (months < -1 * conf_interval) or ((months == -1 * conf_interval) and (days < -1 * reconf))
      months += conf_interval
      creation_date = @batch + months.month + days.day + hours.hour
      insert_conf(new_request.id, creation_date, reconf)
    end
  end
end
