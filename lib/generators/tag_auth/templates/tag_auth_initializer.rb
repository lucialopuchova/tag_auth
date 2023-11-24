require 'openssl'

Rails.application.config.tag_auth_encryption_algorithm = 'AES-256-CBC'
Rails.application.config.tag_auth_encryption_key = OpenSSL::Cipher.new(Rails.application.config.tag_auth_encryption_algorithm).random_key
