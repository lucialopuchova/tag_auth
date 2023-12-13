require 'openssl'

Rails.application.config.tag_auth_encryption_algorithm = 'AES-256-CBC'

# TODO: change for ENV stored key if you are running multiple instances of your app because of load balancing
# Generate the key using the OpenSSL::Cipher.new with your chosen algorithm and use Base64.strict_encode64(your_key) to
# store it in ENV. Then uncomment the row below and delete the existing initialization of the tag_auth_encryption_key.
# Rails.application.config.tag_auth_encryption_key = Base64.strict_decode64(ENV['TAG_AUTH_KEY'])
Rails.application.config.tag_auth_encryption_key = OpenSSL::Cipher.new(Rails.application.config.tag_auth_encryption_algorithm).random_key

TagAuth.configure do |config|
  config.token_validity_duration = 5.minutes
end
