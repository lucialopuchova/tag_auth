require 'openssl'

Rails.application.config.tag_auth_encryption_algorithm = 'AES-256-CBC'
Rails.application.config.tag_auth_encryption_key = OpenSSL::Cipher.new(Rails.application.config.tag_auth_encryption_algorithm).random_key

TagAuth.configure do |config|
  config.token_validity_duration = 5.minutes
end
