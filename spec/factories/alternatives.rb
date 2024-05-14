# frozen_string_literal: true

FactoryBot.define do
  factory :alternative do
    statement { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    correct { false }
    question
  end

  trait :correct_alternative do
    correct { true }
  end
end
