require 'highline'
namespace :api_clients do
  desc 'Create a user and output API key'
  task create: :environment do
    ui = HighLine.new
    name = ui.ask('ApiClient name: ')
    user = ApiClient.new(name: name)
    if user.save
      puts "Api Client '#{name}' created."
      puts "Unsecured Token: #{user.token}"
    else
      puts 'Problem creating user account:'
      puts user.errors.full_messages
    end
  end
end
