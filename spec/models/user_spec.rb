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
end
