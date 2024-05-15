# frozen_string_literal: true

FactoryBot.define do
  factory :quiz_answer do
    quiz
    user

    after(:build) do |quiz_answer|
      quiz_answer.question_answers << build(:question_answer, quiz_answer: quiz_answer)
    end
  end
end
