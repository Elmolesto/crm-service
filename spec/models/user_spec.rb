# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is unique by email" do
    user = create(:user)
    expect { create(:user, email: user.email) }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it "has many created customers" do
    user = create(:user)
    customer = create(:customer, created_by: user)
    expect(user.created_customers).to include(customer)
  end

  it "has many last updated customers" do
    user = create(:user)
    customer = create(:customer, :with_created_by, last_updated_by: user)
    expect(user.last_updated_customers).to include(customer)
  end
end
