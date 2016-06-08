namespace :api_clients do
  desc 'Create a user and output API key'
  task :create, [:name] => :environment do |_, args|
    if args[:name].blank?
      puts '[error] Please supply the name of the API client. ' \
        'Example: rake api_clients:create["my-client"]'
      next
    end

    client = APIClient.create(name: args[:name])

    if client.persisted?
      puts "Your API token is: #{client.token}"
    else
      puts '[error] API client was not created. Errors:'
      puts client.errors.full_messages
    end
  end
end
