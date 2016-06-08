module TokenAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :check_token_presence, :authenticate
  end

  # Verifies if the :token parameter is present in the request, since it is
  # mandatory.
  def check_token_presence
    if params[:token].blank?
      add_request_error(title: I18n.t('api.request.errors.blank_token'))
      render 'application/errors', status: :bad_request
    end
  end

  # Authenticates a request from the token parameter.
  def authenticate
    if APIClient.where(token: params[:token]).none?
      add_request_error(title: I18n.t('api.request.errors.invalid_token'))
      render 'application/errors', status: :unauthorized
    end
  end
end
