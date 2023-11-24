require 'spec_helper'

RSpec.describe TagAuth::EncryptionHelper do
  let(:algorithm) { 'AES-256-CBC' }
  let(:key) { OpenSSL::Cipher.new(algorithm).random_key }
  let(:encryption_helper) { TagAuth::EncryptionHelper.new(algorithm, key) }
  let(:data) { "Test data" }

  describe '#encrypt' do
    it 'encrypts the data' do
      encrypted_data = encryption_helper.encrypt(data)
      expect(encrypted_data).not_to eq(data)
      expect(encrypted_data).to be_a(String)
    end
  end

  describe '#decrypt' do
    it 'decrypts the data back to the original' do
      encrypted_data = encryption_helper.encrypt(data)
      decrypted_data = encryption_helper.decrypt(encrypted_data)
      expect(decrypted_data).to eq(data)
    end

    it 'raises an error with invalid data' do
      invalid_data = 'invalid data'
      expect { encryption_helper.decrypt(invalid_data) }.to raise_error(ArgumentError)
    end
  end

  describe '#encrypt with various data types' do
    it 'correctly encrypts an empty string' do
      encrypted_data = encryption_helper.encrypt('')
      expect(encrypted_data).not_to be_empty
    end

    it 'correctly encrypts numeric data' do
      encrypted_data = encryption_helper.encrypt('12345')
      expect(encrypted_data).to be_a(String)
    end

    it 'correctly encrypts binary data' do
      binary_data = "\x00\x01\x02\x03"
      encrypted_data = encryption_helper.encrypt(binary_data)
      expect(encrypted_data).to be_a(String)
    end
  end

  describe '#decrypt with incorrect key' do
    let(:wrong_key) { OpenSSL::Cipher.new(algorithm).random_key }

    it 'raises an error with a wrong key' do
      encrypted_data = encryption_helper.encrypt(data)
      wrong_encryption_helper = TagAuth::EncryptionHelper.new(algorithm, wrong_key)
      expect { wrong_encryption_helper.decrypt(encrypted_data) }.to raise_error(OpenSSL::Cipher::CipherError)
    end
  end

  describe '#initialize with incorrect algorithm' do
    it 'raises an error with an unknown algorithm' do
      expect { TagAuth::EncryptionHelper.new('unknown-algorithm', key) }.to raise_error(ArgumentError)
    end
  end

  describe '#encrypt and #decrypt idempotency' do
    it 'returns to original state after consecutive encrypt and decrypt' do
      3.times do
        encrypted_data = encryption_helper.encrypt(data)
        decrypted_data = encryption_helper.decrypt(encrypted_data)
        expect(decrypted_data).to eq(data)
      end
    end
  end
end
