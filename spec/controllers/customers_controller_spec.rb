require "rails_helper"

RSpec.describe CustomersController, type: :controller do
  render_views
  let(:user) { create(:user) }
  let(:customer) { create(:customer, :with_created_by) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    it "returns all customers" do
      get :index, as: :json
      expect(response.parsed_body.size).to eq(Customer.count)
    end
  end

  describe "GET #show" do
    it "returns the requested customer" do
      get :show, params: { id: customer.id }, as: :json
      expect(response.parsed_body["id"]).to eq(customer.id)
    end
  end

  describe "POST #create" do
    it "creates a new customer" do
      expect do
        post :create, params: { customer: attributes_for(:customer) }, as: :json
      end.to change(Customer, :count).by(1)
    end
  end

  describe "PUT #update" do
    it "updates the requested customer" do
      put :update, params: { id: customer.id, customer: { name: "New Name" } }, as: :json
      customer.reload
      expect(customer.name).to eq("New Name")
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested customer" do
      customer_to_delete = create(:customer, :with_created_by)
      expect do
        delete :destroy, params: { id: customer_to_delete.id }, as: :json
      end.to change(Customer, :count).by(-1)
    end
  end
end
