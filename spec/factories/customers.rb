# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }

    trait :with_created_by do
      created_by { create(:user) }
    end
  end
end
