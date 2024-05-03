class Question < ApplicationRecord
  has_many :quiz_questions, dependent: :restrict_with_error
  has_many :quizzes, through: :quiz_questions
  has_many :alternatives, dependent: :destroy

  accepts_nested_attributes_for :alternatives
  
  validates :statement, presence: true
  validate :must_have_alternatives

  def multiple?
    alternatives.select(&:correct?).count > 1
  end

  private

  def must_have_alternatives    
    return if alternatives.select(&:correct?).count > 0

    errors.add(:base, :must_have_alternatives)
  end
end
