require 'devise'

module TagAuth
  class TokenAssigner
    def initialize(model_instance)
      @model_instance = model_instance
    end

    def assign_token
      token = generate_token
      @model_instance.update(authentication_token: token, 
                             authentication_token_valid_to: DateTime.current + TagAuth.configuration.token_validity_duration)

      token
    end

    private

    def generate_token
      loop do
        token = Devise.friendly_token
        break token if token_suitable?(token)
      end
    end

    def token_suitable?(token)
      @model_instance.class.where(authentication_token: token).empty?
    end
  end
end
