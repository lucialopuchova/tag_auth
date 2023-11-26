require 'rails/generators/active_record'

module TagAuth
  module Generators
    class ControllerGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Generates a controller responsible for creating one time sign in tokens' \
      "based on model's authentication tag"

      argument :scope, required: true,
                       desc: 'The scope in which controller will be created, e.g. users.' \
                       'It should be compatible with the model provided in other generators'

      def create_controller
        @model = scope.camelize.singularize
        @instance = scope.singularize
        @scope = scope.blank? ? 'Users' : scope.camelize

        template 'tag_auth_controller.rb.erb',
                 'app/controllers/tag_auth_tokens_controller.rb'
      end

      def add_routes
        route 'resources :tag_auth_tokens, only: [:index, :create]'
      end

      def create_initializer
        template 'tag_auth_initializer.rb',
                 'config/initializers/tag_auth_initializer.rb'
      end
    end
  end
end
