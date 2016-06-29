require 'devise'

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end

class DeviseTokenAuthSpecHelper
  def self.age_token(user, client_id)
    if user.tokens[client_id]
      user.tokens[client_id]['updated_at'] = Time.now - (DeviseTokenAuth.batch_request_buffer_throttle + 10.seconds)
      user.save!
    end
  end
end
