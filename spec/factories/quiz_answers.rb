# frozen_string_literal: true

FactoryBot.define do
  factory :quiz_answer do
    quiz
    user
  end
end
