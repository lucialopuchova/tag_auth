require 'rails/generators/active_record'

module TagAuth
  module Generators
    class ControllerGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Generates a controller responsible for creating one time sign in tokens' \
      "based on model's authentication tag"

      argument :scope, required: true,
                       desc: 'The scope in which controller will be created, e.g. users.' \
                       'It should be compatible with the model provided in the tag_auth generator'

      def create_controller
        @model = scope.camelize.singularize
        @instance = scope.singularize
        @scope = scope.blank? ? 'Users' : scope.camelize

        template 'tag_auth_controller.rb.erb',
                 "app/controllers/#{scope}/tag_auth_controller.rb"

      end

      def add_routes
        route "scope module: :#{scope} do"
        route "  get 'tag_auth/sign_in', to: 'tag_auth#new'"
        route "  post 'tag_auth/sign_in', to: 'tag_auth#create'"
        route "end"
      end
    end
  end
end
