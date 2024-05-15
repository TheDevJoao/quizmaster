# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    statement { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }

    after(:build) do |question|
      question.alternatives << build(:alternative, :correct_alternative, question: question)
    end
  end

  factory :question_with_multiple_correct_alternatives, parent: :question do
    after(:build) do |question|
      question.alternatives << build_list(:alternative, 2, correct: true, question: question)
      question.alternatives << build_list(:alternative, 2, correct: false, question: question)
    end
  end

  factory :question_with_no_correct_alternatives, parent: :question do
    after(:build) do |question|
      question.alternatives = build_list(:alternative, 3, correct: false, question: question)
    end
  end
end
