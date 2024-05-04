# frozen_string_literal: true

class Quiz < ApplicationRecord
  has_many :quiz_questions, dependent: :destroy
  has_many :questions, through: :quiz_questions
  has_many :quiz_answers, dependent: :restrict_with_error

  accepts_nested_attributes_for :quiz_questions, allow_destroy: true

  validates :title, presence: true
  validate :must_have_questions
  validate :weight_must_be_one_hundred

  private

  def must_have_questions
    return if quiz_questions.reject(&:marked_for_destruction?).any?

    errors.add(:base, :must_have_questions)
  end

  def weight_must_be_one_hundred
    return if quiz_questions.reject(&:marked_for_destruction?).sum { |q| q.weight.to_i } == 100

    errors.add(:base, :weight_must_be_one_hundred)
  end
end
