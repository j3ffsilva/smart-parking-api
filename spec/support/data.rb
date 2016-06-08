RSpec.configure do |config|
  config.before(:suite) do
    if APIClient.none?
      # Make sure at least one API client exists before running the tests.
      APIClient.create!(name: "api-client-test-#{Time.now.to_f}")
    end
  end
end
