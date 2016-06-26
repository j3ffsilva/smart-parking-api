RSpec.configure do |config|
  config.before(:suite) do
    if APIClient.none?
      # Make sure at least one API client exists before running the tests.
      APIClient.create!(name: "api-client-test-#{Time.now.to_f}")
    end
    if User.none?
      # Make sure at least one API client exists before running the tests.
      User.create!(provider: 'email',
                   uid:      'testemail-user@mydomain.com',
                   name:     'user-test-#{Time.now.to_f}',
                   password: 'password-test-#{Time.now.to_f}',
                   email:    'testemail-user@mydomain.com')
    end
  end
end
