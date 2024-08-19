# frozen_string_literal: true

require "rails_helper"

RSpec.describe Customer, type: :model do
  it "is valid with valid attributes" do
    customer = build(:customer, :with_created_by)
    expect(customer).to be_valid
  end

  it "is not valid without created_by" do
    customer = build(:customer)
    expect(customer).not_to be_valid
  end
end
