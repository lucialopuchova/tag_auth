require 'spec_helper'
require 'generator_spec'
require 'generators/tag_auth/controller_generator'

RSpec.describe TagAuth::Generators::ControllerGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __dir__)

  let(:controller_file) { 'app/controllers/tag_auth_tokens_controller.rb' }
  let(:initializer_file) { 'config/initializers/tag_auth_initializer.rb' }
  let(:routes_file) { 'config/routes.rb' }

  before do
    prepare_destination
    copy_routes
    run_generator ['users']
  end

  after do
    FileUtils.rm_rf(destination_root)
  end

  it 'creates a controller file' do
    expected_file = File.join(destination_root, controller_file)
    expect(File.exist?(expected_file)).to be true

    content = File.read(expected_file)
    expect(content).to include('class TagAuthTokensController < ApplicationController')
  end

  it 'creates an initializer file' do
    expected_file = File.join(destination_root, initializer_file)
    expect(File.exist?(expected_file)).to be true

    # Add content checks for initializer if necessary
  end

  it 'adds routes to the routes file' do
    expected_file = File.join(destination_root, routes_file)
    expect(File.exist?(expected_file)).to be true

    content = File.read(expected_file)
    expect(content).to include('resources :tag_auth_tokens, only: [:index, :create]')
  end

  def copy_routes
    routes = File.expand_path('../../../dummy_app_files/routes.rb', __dir__)
    destination = File.join(destination_root, 'config')

    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, destination
  end
end
