# frozen_string_literal: true

class Alternative < ApplicationRecord
  belongs_to :question
  has_many :question_answers, dependent: :restrict_with_error

  validates :statement, presence: true
end
