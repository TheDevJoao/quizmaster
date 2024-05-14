# frozen_string_literal: true

FactoryBot.define do
  factory :quiz do
    title { Faker::Game.title }
    description { Faker::Lorem.paragraph }

    after(:build) do |quiz|
      quiz.quiz_questions << build(:quiz_question, quiz: quiz, weight: 50)
      quiz.quiz_questions << build(:quiz_question, quiz: quiz, weight: 50)
    end
  end
end
