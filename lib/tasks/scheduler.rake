desc "Send reminders to renew requests confirmation"
task daily_procs: :environment do
  puts "Send confirmation renewal reminders..."
  RemindersJob.perform_now

  puts "Close unconfirmed requests..."
  ExpiredJob.perform_now
end
