# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Customer endpoints", type: :request do
  include AuthHelper
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let!(:customer) { create(:customer, :with_created_by) }
  let!(:headers) { auth_headers(user) }

  it "Get all customers (/customers)" do
    get("/customers", headers:)

    expect(response).to have_http_status(:success)
    customers = response.parsed_body
    expect(customers.length).to eq(Customer.count)
  end

  it "Get one customer (/customers/:id)" do
    get("/customers/#{customer.id}", headers:)

    expect(response).to have_http_status(:success)
    json_customer = response.parsed_body
    expect(json_customer["name"]).to eq(customer.name)
    expect(json_customer["surname"]).to eq(customer.surname)
    expect(json_customer["created_by"]["id"]).to eq(customer.created_by_id)
  end

  it "Create new customer (/customers)" do
    customer_attributes = attributes_for(:customer)
    customer_attributes[:photo] = fixture_file_upload("avatar.jpg", "image/jpg")
    expect do
      post "/customers", params: { customer: customer_attributes }, headers:
    end.to change(Customer, :count).by(1)

    expect(response).to have_http_status(:success)
    json_customer = response.parsed_body
    expect(json_customer["name"]).to eq(customer_attributes[:name])
    expect(json_customer["surname"]).to eq(customer_attributes[:surname])
    expect(json_customer["created_by"]["id"]).to eq(user.id)
    expect(json_customer["photo_url"]).to match(/avatar.jpg/)
  end

  it "Update customer data (/customers/:id)" do
    customer = create(:customer, :with_created_by)
    headers = auth_headers(admin)

    new_attributes = attributes_for(:customer)
    new_attributes[:photo] = fixture_file_upload("avatar2.jpg", "image/jpg")
    patch("/customers/#{customer.id}", params: { customer: new_attributes }, headers:)

    expect(response).to have_http_status(:success)
    json_customer = response.parsed_body
    expect(json_customer["name"]).to eq(new_attributes[:name])
    expect(json_customer["surname"]).to eq(new_attributes[:surname])
    expect(json_customer["created_by"]["id"]).to eq(customer.created_by.id)
    expect(json_customer["last_updated_by"]["id"]).to eq(admin.id)
    expect(json_customer["photo_url"]).to match(/avatar2.jpg/)
  end

  it "Delete customer (/customers/:id)" do
    expect do
      delete "/customers/#{customer.id}", headers:
    end.to change(Customer, :count).by(-1)

    expect(response).to have_http_status(:success)
    expect(Customer.exists?(customer.id)).to be_falsey
  end
end
