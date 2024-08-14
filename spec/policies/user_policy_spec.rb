# frozen_string_literal: true

# spec/policies/user_policy_spec.rb
require "rails_helper"

RSpec.describe UserPolicy do
  subject { described_class }

  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  permissions :index? do
    it "grants access if user is an admin" do
      expect(subject).to permit(admin, User)
    end

    it "denies access if user is not an admin" do
      expect(subject).not_to permit(user, User)
    end
  end

  permissions :create?, :show?, :update?, :destroy?, :change_admin_status? do
    it "grants access if user is an admin" do
      expect(subject).to permit(admin, user)
    end

    it "denies access if user is not an admin" do
      expect(subject).not_to permit(user, user)
    end
  end
end
