class ApiClient < ApplicationRecord
  attr_accessor :unsecure_token, :decrypted_token

  validates :encrypted_token, uniqueness: true
  validates :name, presence: true

  before_create :generate_encrypted_token
  after_find :decrypt_token

  def generate_encrypted_token
    self.encrypted_token = loop do
      self.unsecure_token = SecureRandom.base64.tr('+/=', 'Qrt')
      token = BCrypt::Password.create(unsecure_token)
      break token unless ApiClient.where(encrypted_token: token).exists?
    end
  end

  def decrypt_token
    self.decrypted_token = BCrypt::Password.new(encrypted_token)
  end
end
