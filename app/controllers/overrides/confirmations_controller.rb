module Overrides
  class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
    skip_before_action :check_token_presence, :authenticate
  end
end
