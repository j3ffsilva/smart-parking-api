class ApiClient < ApplicationRecord
  validates :encrypted_token, uniqueness: true
  validates :name, presence: true

  # The block below has academic purposes and could be replaced
  # by a single line of code since Rails 5:
  # has_secure_token :encrypted_token

  before_create :generate_encrypted_token

  def generate_encrypted_token
    self.encrypted_token = loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless ApiClient.where(encrypted_token: token).exists?
    end
  end
end
