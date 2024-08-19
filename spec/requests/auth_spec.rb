# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Customer endpoints", type: :request do
  include AuthHelper
  let!(:user) { create(:user) }

  it "Sign in and gets Bearer token" do
    post "/users/sign_in", params: {
      user: {
        email: user.email,
        password: user.password,
      },
    }

    expect(response).to have_http_status(:success)
    expect(response.headers["Authorization"]).to be_present
    expect(response.parsed_body.dig("data", "user", "email")).to eq(user.email)
  end

  it "Sign out" do
    headers = auth_headers(user)
    expect do
      delete("/users/sign_out", headers:)
    end.to change(JwtDenylist, :count).by(1)
    expect(response).to have_http_status(:success)

    # Try to get customers with same token
    get("/customers", headers:)
    expect(response).to have_http_status(:unauthorized)
  end
end
