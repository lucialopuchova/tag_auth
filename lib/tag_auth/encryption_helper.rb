module TagAuth
  class EncryptionHelper
    require 'openssl'
    require 'base64'

    def initialize(algorithm, key)
      raise ArgumentError, 'Invalid algorithm' unless valid_algorithm?(algorithm.downcase)
      raise ArgumentError, 'Invalid key length' unless valid_key?(key, algorithm)

      @algorithm = algorithm.downcase
      @key = key
    end

    def encrypt(data)
      cipher = OpenSSL::Cipher.new(@algorithm)
      cipher.encrypt
      cipher.key = @key
      iv = cipher.random_iv

      encrypted_data = cipher.update(data) + cipher.final

      Base64.encode64(encrypted_data + iv)
    end

    def decrypt(encrypted_string)
      decipher = OpenSSL::Cipher.new(@algorithm)
      decipher.decrypt
      decipher.key = @key

      decoded_data = Base64.decode64(encrypted_string)

      iv_len = decipher.iv_len
      data_len = decoded_data.length - iv_len

      encrypted_data = decoded_data[0, data_len]
      iv = decoded_data[data_len, iv_len]

      decipher.iv = iv
      decipher.update(encrypted_data) + decipher.final
    end

    private

    def valid_algorithm?(algorithm)
      OpenSSL::Cipher.ciphers.include?(algorithm)
    end

    def valid_key?(key, algorithm)
      cipher = OpenSSL::Cipher.new(algorithm)
      key_length = key.bytesize * 8 # Convert byte length to bit length
      key_length == cipher.key_len * 8
    end
  end
end
