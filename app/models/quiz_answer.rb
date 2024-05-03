class QuizAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :quiz

  has_many :question_answers

  accepts_nested_attributes_for :question_answers
end
