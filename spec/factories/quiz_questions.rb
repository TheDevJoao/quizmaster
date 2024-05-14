# frozen_string_literal: true

FactoryBot.define do
  factory :quiz_question do
    question
    quiz

    weight { 100 }
    sequence(:position) { |n| n }
  end
end
