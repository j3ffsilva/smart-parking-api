module DeviseTokenAuth
  class ConfirmationsController < DeviseTokenAuth::ApplicationController
    skip_before_action :check_token_presence, :authenticate
  end
end
