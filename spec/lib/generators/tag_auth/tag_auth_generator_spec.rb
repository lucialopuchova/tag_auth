require 'spec_helper'
require 'generator_spec'
require 'generators/tag_auth/tag_auth_generator'

RSpec.describe TagAuth::Generators::TagAuthGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __dir__)

  let(:timestamp_regex) { /\d{14}/ }
  let(:migration_name) { "add_auth_tag_and_token_to_#{@table_name}" }

  before(:all) do
    prepare_destination

    model_name = 'User'
    @table_name = model_name.downcase.pluralize

    run_generator [model_name]
  end

  after(:all) do
    FileUtils.rm_rf(destination_root)
  end

  it 'generates a migration file' do
    generated_migration_files = Dir.glob(File.join(destination_root, 'db/migrate/*.rb'))

    generated_migration_file = generated_migration_files.find do |file|
      File.basename(file) =~ /^#{timestamp_regex}_#{migration_name}\.rb$/
    end

    expect(generated_migration_file).not_to be_nil

    migration_content = File.read(generated_migration_file)
    expect(migration_content).to include("class #{migration_name.camelize}")

    expect(migration_content).to include('def up')
    expect(migration_content).to include("add_column :#{@table_name}, :auth_tag, :string")

    expect(migration_content).to include('def down')
    expect(migration_content).to include("remove_column :#{@table_name}, :auth_tag")
  end
end
