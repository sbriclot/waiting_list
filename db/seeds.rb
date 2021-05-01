# 1. clean all the tables
p "Clean DB..."
Confirmation.delete_all
Request.delete_all
Delay.delete_all

# 2. insert the parameters
p "Insert the default Delays..."
Delay.create(name: 'req_reconfirmation',
  value: 3,
  description: 'Delay between 2 validation email, in months')
Delay.create(name: 'confirmation_validity',
  value: 1,
  description: 'Validity duration of the link for the first confirmation mail, in_days')
Delay.create(name: 'reconfirmation_validity',
  value: 3,
  description: 'Validity duration of the link for the reconfirmations mail, in days')

today = Time.now

# 3. create a request already validated and accpted
p "Insert 1 accepted request..."
creation_date = today - Random.new.rand(5..10).days
req1 = Request.new(name: 'Etienne',
  email: 'etienne@mail.com',
  phone: 0601020304,
  bio: 'PL/SQL expert',
  confirmed: true,
  accepted_at: creation_date + 1.hours,
  created_at: creation_date,
  updated_at: creation_date)
req1.save
Confirmation.create(request_id: req1.id,
  validation_key: SecureRandom.hex(8),
  reply_delay: 1,
  replied_at: req1.accepted_at)

# 4. create a request already expired and accpted
p "Insert 1 expired request..."
creation_date = today - Random.new.rand(5..10).days
req2 = Request.new(name: 'Steve',
  email: 'steve@mail.com',
  phone: 0611121314,
  bio: 'PL/SQL addict',
  confirmed: false,
  expired_at: creation_date + 1.days,
  created_at: creation_date,
  updated_at: creation_date)
req2.save
Confirmation.create(request_id: req2.id,
  validation_key: SecureRandom.hex(8),
  reply_delay: 1)

# 5. create a request already expired and accpted
p "Insert 1 3 months old request..."
creation_date = today - 3.months
req3 = Request.new(name: 'Stéphane',
  email: 'vtorrey.wesleeyh@moyencuen.buzz',
  phone: 0621222324,
  bio: 'PL/SQL addict',
  confirmed: true,
  created_at: creation_date,
  updated_at: creation_date)
req3.save
Confirmation.create(request_id: req3.id,
  validation_key: SecureRandom.hex(8),
  reply_delay: 1,
  replied_at: req3.created_at + 2.hours)

  