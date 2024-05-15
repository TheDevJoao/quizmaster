# frozen_string_literal: true

FactoryBot.define do
  factory :quiz_question do
    question
    quiz

    weight { 100 }
    sequence(:position) { |n| n }

    after(:create) do |quiz_question|
      quiz_question.question.alternatives.each do |alternative|
        create(:quiz_answer, quiz_question: quiz_question, alternative: alternative)
      end
    end
  end

  factory :quiz_question_with_multiple_correct_alternatives, parent: :quiz_question do
    after(:build) do |quiz_question|
      quiz_question.question = build(:question_with_multiple_correct_alternatives)
    end

    after(:create) do |quiz_question|
      quiz_question.question.alternatives.each do |alternative|
        create(:quiz_answer, quiz_question: quiz_question, alternative: alternative)
      end
    end
  end
end
