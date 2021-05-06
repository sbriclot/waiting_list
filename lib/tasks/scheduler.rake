desc "Send reminders to renew requests confirmation"
task proc_reminders: :environment do
  puts "Send confirmation renewal reminders..."
  RemindersJob.perform_now
end

desc "Automatically close unconfirmed requests"
task proc_expired: :environment do
  puts "Close unconfirmed requests..."
  ExpiredJob.perform_now
end
