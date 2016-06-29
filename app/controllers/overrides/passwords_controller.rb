module Overrides
  class PasswordsController < DeviseTokenAuth::PasswordsController
    skip_before_action :check_token_presence, :authenticate
  end
end
