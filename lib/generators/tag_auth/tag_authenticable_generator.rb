require 'rails/generators/active_record'

module TagAuth
  module Generators
    class TagAuthenticableGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Generates a Devise strategy for authenticating a user by tag'

      argument :scope, required: true,
                       desc: 'The scope in which controller will be created, e.g. users.' \
                       'It should be compatible with the model provided in other generators'

      def create_controller
        @model = scope.camelize.singularize
        @instance = scope.singularize
        @scope = scope.blank? ? 'Users' : scope.camelize

        template 'tag_authenticable.rb.erb',
                 'config/initializers/tag_authenticable.rb'
      end
    end
  end
end
