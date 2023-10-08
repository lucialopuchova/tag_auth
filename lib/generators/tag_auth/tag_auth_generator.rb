require 'rails/generators/active_record'
require 'rails/version'

module TagAuth
  module Generators
    class TagAuthGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc 'Generates a migration modifying a table with the given NAME which' \
           "adds a new column for storing user's tag value."

      def copy_tag_auth_migration
        migration_template 'add_tag_column_migration.rb.erb', "#{migration_path}/add_auth_tag_to_#{file_path.pluralize}.rb", migration_version: migration_version
      end

      def migration_path
        File.join('db', 'migrate')
      end

      def migration_version
        return unless Rails::VERSION::MAJOR >= 5

        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end

    end
  end
end
