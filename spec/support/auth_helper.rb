# frozen_string_literal: true

module AuthHelper
  def auth_headers(user)
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end
end
