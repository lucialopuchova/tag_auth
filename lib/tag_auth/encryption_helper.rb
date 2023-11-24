module EncryptionHelper
  require 'openssl'
  require 'base64'

  ALGORITHM = Rails.application.config.tag_auth_encryption_algorithm.freeze

  def self.encrypt(data)
    cipher = OpenSSL::Cipher.new(ALGORITHM)
    cipher.encrypt
    cipher.key = Rails.application.config.tag_auth_encryption_key
    iv = cipher.random_iv

    encrypted_data = cipher.update(data) + cipher.final

    Base64.encode64(encrypted_data + iv)
  end

  def self.decrypt(encrypted_string)
    decipher = OpenSSL::Cipher.new(ALGORITHM)
    decipher.decrypt
    decipher.key = Rails.application.config.tag_auth_encryption_key

    decoded_data = Base64.decode64(encrypted_string)

    iv_len = decipher.iv_len
    data_len = decoded_data.length - iv_len

    encrypted_data = decoded_data[0, data_len]
    iv = decoded_data[data_len, iv_len]

    decipher.iv = iv
    decipher.update(encrypted_data) + decipher.final
  end
end
