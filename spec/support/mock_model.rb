class MockModel
  attr_accessor :authentication_token, :authentication_token_valid_to

  def update(attributes)
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end
end
