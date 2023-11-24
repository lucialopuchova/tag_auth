require 'spec_helper'
require 'devise'

RSpec.describe TagAuth::TokenAssigner do
  let(:mock_model) { MockModel.new }
  let(:token_assigner) { described_class.new(mock_model) }
  let(:token) { 'token123' }

  before do
    allow(Devise).to receive(:friendly_token).and_return(token)

    TagAuth.configure do |config|
      config.token_validity_duration = 30.minutes
    end

    allow(MockModel).to receive(:where).and_return([])
  end

  describe '#assign_token' do
    it 'assigns a unique token to the model instance' do
      token_assigner.assign_token
      expect(mock_model.authentication_token).to eq(token)
    end

    it 'sets the token validity duration correctly' do
      token_assigner.assign_token
      expect(mock_model.authentication_token_valid_to).to be_within(1.second).of(DateTime.current + 30.minutes)
    end

    it 'ensures token is regenerated until a unique one is found' do
      existing_model = MockModel.new
      existing_model.update(authentication_token: token)

      allow(mock_model.class).to receive(:where).and_return([existing_model], [])
      new_token = 'token456'
      allow(Devise).to receive(:friendly_token).and_return(token, new_token)

      token_assigner.assign_token
      expect(mock_model.authentication_token).not_to eq(token)
      expect(mock_model.authentication_token).to eq(new_token)
    end
  end
end

