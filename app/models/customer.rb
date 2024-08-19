# frozen_string_literal: true

class Customer < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :created_by, class_name: "User"
  belongs_to :last_updated_by, class_name: "User", optional: true

  validates :name, :surname, presence: true
  has_one_attached :photo, dependent: :destroy
end
