require 'rails/generators/active_record'

module TagAuth
  module Generators
    class ControllerGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Generates a controller responsible for creating one time tokens' \
      'and user authentication with tokens'

      argument :scope, required: true,
                       desc: 'The scope in which controller will be created, e.g. users.' \
                       'It should be compatible with the model provided in the tag_auth generator'

      def create_controller
        @scope_prefix = scope.blank? ? 'Users' : "#{scope.camelize}::"

        template 'tag_auth_tokens_controller.rb.erb',
                 "app/controllers/#{scope}/tag_auth_token_controller.rb"

      end

      def add_routes
        route "post '/tag_auth/generate_token', to: 'tag_auth_tokens#generate_token'"
        route "post '/tag_auth/login_with_token', to: 'tag_auth_tokens#login_with_token'"
      end
    end
  end
end
