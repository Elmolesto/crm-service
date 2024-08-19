# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :created_customers, foreign_key: :created_by_id, class_name: "Customer",
                               dependent: :restrict_with_error, inverse_of: :created_by
  has_many :last_updated_customers, foreign_key: :last_updated_by_id, class_name: "Customer",
                                    dependent: :restrict_with_error, inverse_of: :last_updated_by
end
