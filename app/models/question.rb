class Question < ApplicationRecord
  include AttrJson::Record

  has_many :question_quizzes
  has_many :quizzes, through: :question_quizzes

  attr_json_config(default_container_attribute: :config)

  attr_json :type, :string
  attr_json :alternatives, Question::Alternatives.to_type, default: [], array: true
  attr_json :correct_alternative, :string
end
