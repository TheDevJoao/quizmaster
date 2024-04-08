class Quiz < ApplicationRecord
  has_many :question_quizzes
  has_many :questions, through: :question_quizzes
end
