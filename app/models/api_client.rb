class APIClient < ApplicationRecord
  # Validations
  validates :token, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  # Callbacks
  before_validation :generate_token

  # Generate a new API token for the client, making sure that the
  # token is unique.
  def generate_token
    self.token = loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless APIClient.where(token: token).exists?
    end
  end
end
