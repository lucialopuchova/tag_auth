# frozen_string_literal: true

require_relative 'tag_auth/version'
require 'tag_auth/encryption_helper'
require 'tag_auth/token_assigner'
require 'tag_auth/configuration'

module TagAuth
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
