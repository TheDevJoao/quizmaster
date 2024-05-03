class Alternative < ApplicationRecord
  belongs_to :question
  has_many :question_answers
  
  validates :statement, presence: true
end
