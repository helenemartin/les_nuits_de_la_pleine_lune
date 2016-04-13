desc "This task is called by the Heroku scheduler add-on"
task :send_email => :environment do
  puts "Updating feed..."
  LunaTic.remind
  puts "done."
end

task :send_reminders => :environment do
  User.send_reminders
end