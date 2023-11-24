module TagAuth
  class Configuration
    attr_accessor :token_validity_duration

    def initialize
      @token_validity_duration = 5.minutes
    end

    def configure
      yield self if block_given?
    end
  end
end
