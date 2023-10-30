module TagAuthTokenAuthenticationHandler
  private

  def token_correct?(record, entity, token_comparator)
    token_not_expired?(record) && super
  end

  def token_not_expired?(record)
    return false unless record.authentication_token_valid_to

    Time.now <= record.authentication_token_valid_to
  end
end
