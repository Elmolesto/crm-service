# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller, format: :json do
  render_views
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  describe "GET #index" do
    it "return all users" do
      sign_in(admin)
      get :index
      expect(response.parsed_body.size).to eq(User.count)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a user" do
      sign_in(admin)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
      expect(response.parsed_body["email"]).to eq(user.email)
    end

    it "does not allow non-admins to view users" do
      sign_in(user)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      sign_in(admin)
      email = Faker::Internet.email
      post :create, params: { user: { email:, password: "password" } }
      expect(User.last.email).to eq(email)
    end

    it "does not allow non-admins to create users" do
      sign_in(user)
      email = Faker::Internet.email
      post :create, params: { user: { email:, password: "password" } }
      expect(response).to have_http_status(:unauthorized)
      expect(User.last.email).not_to eq(email)
    end
  end

  describe "PATCH #update" do
    it "updates a user" do
      sign_in(admin)
      email = Faker::Internet.email
      patch :update, params: { id: user.id, user: { email: } }
      expect(user.reload.email).to eq(email)
    end

    it "does not allow non-admins to update users" do
      sign_in(user)
      email = Faker::Internet.email
      patch :update, params: { id: user.id, user: { email: } }
      expect(response).to have_http_status(:unauthorized)
      expect(user.reload.email).not_to eq(email)
    end
  end

  describe "DELETE #destroy" do
    it "deletes a user" do
      new_user = create(:user)
      sign_in(admin)
      expect do
        delete :destroy, params: { id: new_user.id }
      end.to change(User, :count).by(-1)
      expect { User.find(new_user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "does not allow non-admins to delete users" do
      sign_in(user)
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(:unauthorized)
      expect(User.find(user.id)).to eq(user)
    end

    it "does not allow admins to delete themselves" do
      sign_in(admin)
      delete :destroy, params: { id: admin.id }
      expect(response).to have_http_status(:unauthorized)
    end

    it "does not allow to delete users with created customers" do
      sign_in(admin)
      user = create(:user)
      create(:customer, created_by: user)
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(422)
      expect(User.find(user.id)).to eq(user)
    end

    it "does not allow to delete users with last updated customers" do
      sign_in(admin)
      user = create(:user)
      create(:customer, :with_created_by, last_updated_by: user)
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(422)
      expect(User.find(user.id)).to eq(user)
    end
  end

  describe "PATCH #change_admin_status" do
    it "allows an admin to change another user's admin status" do
      sign_in(admin)
      patch :change_admin_status, params: { id: user.id, user: { admin: true } }
      user.reload
      expect(user.admin).to be_truthy
    end

    it "does not allow non-admins to change admin status" do
      sign_in(user)
      patch :change_admin_status, params: { id: user.id, user: { admin: true } }
      user.reload
      expect(user.admin).to be_falsey
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
