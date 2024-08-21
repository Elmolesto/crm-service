# frozen_string_literal: true

json.extract! customer, :id, :name, :surname
json.photo_url customer.photo.attached? ? customer.photo.url : json.null
json.created_by customer.created_by, :id, :email
json.last_updated_by do
  customer.last_updated_by ? (json.extract! customer.last_updated_by, :id, :email) : json.null!
end
json.created_at customer.created_at.strftime("%F %T")
json.updated_at customer.updated_at.strftime("%F %T")
