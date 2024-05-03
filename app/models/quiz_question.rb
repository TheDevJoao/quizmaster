class QuizQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :quiz

  has_many :question_answers, dependent: :restrict_with_error

  validates :weight, :position, presence: true
  validate :weight_must_be_integer

  private

  def weight_must_be_integer
    return unless question.present? && weight.present?

    correct_alternatives = question.alternatives.select(&:correct?).count

    errors.add(:base, :weight_must_be_integer) if weight % correct_alternatives > 0
  end
end
