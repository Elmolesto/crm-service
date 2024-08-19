# frozen_string_literal: true

json.extract! user, :id, :email, :admin
json.created_at user.created_at.strftime("%F %T")
json.updated_at user.updated_at.strftime("%F %T")
