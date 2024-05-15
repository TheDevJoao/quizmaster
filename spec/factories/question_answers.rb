# frozen_string_literal: true

FactoryBot.define do
  factory :question_answer do
    quiz_answer
    quiz_question
    alternative
  end
end
