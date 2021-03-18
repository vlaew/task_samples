# frozen_string_literal: true

module AuthHelper
  def auth_headers(user)
    { 'Authorization' => "Token #{user.token}" }
  end
end
