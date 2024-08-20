# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User endpoints", type: :request do
  include AuthHelper

  context "User without admin rights" do
    let(:user) { create(:user) }
    let!(:headers) { auth_headers(user) }

    it "canot do anything without admin rights" do
      get("/v1/users", headers:)
      expect(response).to have_http_status(:forbidden)

      get("/v1/users/#{user.id}", headers:)
      expect(response).to have_http_status(:forbidden)

      post("/v1/users", params: { user: attributes_for(:user) }, headers:)
      expect(response).to have_http_status(:forbidden)

      patch("/v1/users/#{user.id}", params: { user: { admin: true } }, headers:)
      expect(response).to have_http_status(:forbidden)

      delete("/v1/users/#{user.id}", headers:)
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "User with admin rights" do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }

    before do
      sign_in(admin)
    end

    it "Get all users (/v1/users)" do
      get "/v1/users"

      expect(response).to have_http_status(:success)
      users = response.parsed_body
      expect(users.length).to eq(User.count)
    end

    it "Get one user (/v1/users/:id)" do
      get "/v1/users/#{user.id}"

      expect(response).to have_http_status(:success)
      json_user = response.parsed_body
      expect(json_user["email"]).to eq(user.email)
      expect(json_user["admin"]).to eq(user.admin)
    end

    it "Create new user (/v1/users)" do
      user_attributes = attributes_for(:user)
      expect do
        post "/v1/users", params: { user: user_attributes }
      end.to change(User, :count).by(1)

      expect(response).to have_http_status(:success)
      json_user = response.parsed_body
      expect(json_user["email"]).to eq(user_attributes[:email])
      expect(json_user["admin"]).to eq(false)
    end

    it "Create new admin user (/v1/users)" do
      user_attributes = attributes_for(:user, admin: true)
      expect do
        post "/v1/users", params: { user: user_attributes }
      end.to change(User, :count).by(1)

      expect(response).to have_http_status(:success)
      json_user = response.parsed_body
      expect(json_user["email"]).to eq(user_attributes[:email])
      expect(json_user["admin"]).to eq(true)
    end

    it "Update user (/v1/users/:id)" do
      user_attributes = attributes_for(:user)
      patch "/v1/users/#{user.id}", params: { user: user_attributes }

      expect(response).to have_http_status(:success)
      json_user = response.parsed_body
      expect(json_user["email"]).to eq(user_attributes[:email])
    end

    it "Delete user (/v1/users/:id)" do
      user_to_delete = create(:user)
      expect do
        delete "/v1/users/#{user_to_delete.id}"
      end.to change(User, :count).by(-1)

      expect(response).to have_http_status(:success)
    end

    it "Cannot delete themself (/v1/users/:id)" do
      expect do
        delete "/v1/users/#{admin.id}"
      end.not_to change(User, :count)

      expect(response).to have_http_status(:forbidden)
    end

    it "Cannot delete a user with created customers (/v1/users/:id)" do
      user_to_delete = create(:user)
      create(:customer, created_by: user_to_delete)
      expect do
        delete "/v1/users/#{user_to_delete.id}"
      end.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_content)
    end

    it "Cannot delete a user with last updated customers (/v1/users/:id)" do
      user_to_delete = create(:user)
      create(:customer, :with_created_by, last_updated_by: user_to_delete)
      expect do
        delete "/v1/users/#{user_to_delete.id}"
      end.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_content)
    end

    it "Change admin status to user (/v1/users/:id/admin_status)" do
      patch "/v1/users/#{user.id}/admin_status", params: { user: { admin: true } }

      expect(response).to have_http_status(:success)
      json_user = response.parsed_body
      expect(json_user["admin"]).to eq(true)
    end
  end
end
