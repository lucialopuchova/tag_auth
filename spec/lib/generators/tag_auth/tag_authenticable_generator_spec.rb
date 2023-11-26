require 'spec_helper'
require 'generator_spec'
require 'generators/tag_auth/tag_authenticable_generator'

RSpec.describe TagAuth::Generators::TagAuthenticableGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __dir__)

  let(:initializer_file) { 'config/initializers/tag_authenticable.rb' }

  before do
    prepare_destination
    run_generator ['users']
  end

  after do
    FileUtils.rm_rf(destination_root)
  end

  it 'creates a tag authenticable initializer file' do
    expected_file = File.join(destination_root, initializer_file)
    expect(File.exist?(expected_file)).to be true

    content = File.read(expected_file)
    expect(content).to include('module Devise')
    expect(content).to include('class TagAuthenticable')
  end
end
