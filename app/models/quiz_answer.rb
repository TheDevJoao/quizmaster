# frozen_string_literal: true

class QuizAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :quiz

  has_many :question_answers, dependent: :destroy

  accepts_nested_attributes_for :question_answers

  validate :must_have_answers

  private

  def must_have_answers
    return if question_answers.any?

    errors.add(:base, :must_have_answers)
  end
end
