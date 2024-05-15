# frozen_string_literal: true

FactoryBot.define do
  factory :quiz do
    title { Faker::Game.title }
    description { Faker::Lorem.paragraph }

    after(:build) do |quiz|
      quiz.quiz_questions << build(:quiz_question, quiz: quiz, weight: 40)
      quiz.quiz_questions << build(:quiz_question, quiz: quiz, weight: 30)
      quiz.quiz_questions << build(:quiz_question_with_multiple_correct_alternatives, quiz: quiz, weight: 30)
    end
  end
end
