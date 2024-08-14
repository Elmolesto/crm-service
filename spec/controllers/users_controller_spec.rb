# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  describe "GET #index" do
    it "return all users" do
      sign_in admin
      get :index
      expect(response.parsed_body.size).to eq(User.count)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a user" do
      sign_in admin
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
      expect(response.parsed_body["email"]).to eq(user.email)
    end

    it "does not allow non-admins to view users" do
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      sign_in admin
      email = Faker::Internet.email
      post :create, params: { user: { email:, password: "password" } }
      expect(User.last.email).to eq(email)
    end

    it "does not allow non-admins to create users" do
      sign_in user
      email = Faker::Internet.email
      post :create, params: { user: { email:, password: "password" } }
      expect(response).to have_http_status(:unauthorized)
      expect(User.last.email).not_to eq(email)
    end
  end

  describe "PATCH #update" do
    it "updates a user" do
      sign_in admin
      email = Faker::Internet.email
      patch :update, params: { id: user.id, user: { email: } }
      expect(user.reload.email).to eq(email)
    end

    it "does not allow non-admins to update users" do
      sign_in user
      email = Faker::Internet.email
      patch :update, params: { id: user.id, user: { email: } }
      expect(response).to have_http_status(:unauthorized)
      expect(user.reload.email).not_to eq(email)
    end
  end

  describe "DELETE #destroy" do
    it "deletes a user" do
      sign_in admin
      delete :destroy, params: { id: user.id }
      expect(response.parsed_body[:message]).to eq(I18n.t("users_controller.destroyed"))
      expect { User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "does not allow non-admins to delete users" do
      sign_in user
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(:unauthorized)
      expect(User.find(user.id)).to eq(user)
    end
  end

  describe "PATCH #change_admin_status" do
    it "allows an admin to change another user's admin status" do
      sign_in admin
      patch :change_admin_status, params: { id: user.id, user: { admin: true } }
      user.reload
      expect(user.admin).to be_truthy
    end

    it "does not allow non-admins to change admin status" do
      sign_in user
      patch :change_admin_status, params: { id: admin.id, user: { admin: false } }
      admin.reload
      expect(admin.admin).to be_truthy
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
