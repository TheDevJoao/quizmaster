class QuestionAnswer < ApplicationRecord
  belongs_to :quiz_answer
  belongs_to :quiz_question
  belongs_to :alternative
end
