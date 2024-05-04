# frozen_string_literal: true

class QuizQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :quiz

  has_many :question_answers, dependent: :restrict_with_error

  validates :weight, :position, presence: true
  validate :weight_must_be_integer

  private

  # rubocop:disable Metrics/AbcSize
  def weight_must_be_integer
    return unless question.present? && weight.present?

    correct_alternatives = question.alternatives.select(&:correct?).count
    incorrect_alternatives = question.alternatives.reject(&:correct?).count

    return unless (weight % correct_alternatives).positive? || (weight % incorrect_alternatives).positive?

    errors.add(:base, :weight_must_be_integer)
  end
  # rubocop:enable Metrics/AbcSize
end
