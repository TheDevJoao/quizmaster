# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

question_1 = Question.create(
  "identifier"=>"one_plus_one",
  "statement"=>"How much is 1 + 1?",
  "description"=>nil,
  "config"=>
  {
    "type"=>"simple_multiple_choice",
    "alternatives"=> [
      {"text"=>"1", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"one", "text_color"=>"#000000"},
      {"text"=>"2", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"two", "text_color"=>"#000000"},
      {"text"=>"3", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"three", "text_color"=>"#000000"},
      {"text"=>"4", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"four", "text_color"=>"#000000"}
    ],
    "correct_alternative"=>"two"
  }
)

question_2 = Question.create(
  "identifier"=>"two_plus_two",
  "statement"=>"How much is 2 + 2?",
  "description"=>nil,
  "config"=>
  {
    "type"=>"simple_multiple_choice",
    "alternatives"=> [
      {"text"=>"3", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"three", "text_color"=>"#000000"},
      {"text"=>"4", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"four", "text_color"=>"#000000"},
      {"text"=>"5", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"five", "text_color"=>"#000000"},
      {"text"=>"6", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"six", "text_color"=>"#000000"}
    ],
    "correct_alternative"=>"four"
  }
)

question_3 = Question.create(
  "identifier"=>"one_plus_two",
  "statement"=>"How much is 1 + 2?",
  "description"=>nil,
  "config"=>
  {
    "type"=>"simple_multiple_choice",
    "alternatives"=> [
      {"text"=>"1", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"one", "text_color"=>"#000000"},
      {"text"=>"2", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"two", "text_color"=>"#000000"},
      {"text"=>"3", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"three", "text_color"=>"#000000"},
      {"text"=>"4", "bg_color"=>"#808080", "image_url"=>"", "identifier"=>"four", "text_color"=>"#000000"}
    ],
    "correct_alternative"=>"three"
  }
)

quiz = Quiz.create(
  "identifier"=>"basic_algebra",
  "title"=>"Basic Algebra",
  "description"=>"This is a basic algebra quiz",
  "config"=>{},
  "result_calculator"=>"RightAnswerCounter"
)

QuestionQuiz.create(question: question_1, quiz: quiz, order: 1)
QuestionQuiz.create(question: question_2, quiz: quiz, order: 2)
QuestionQuiz.create(question: question_3, quiz: quiz, order: 3)

User.create(email: 'user@email.com', password: 's3nh4f4c1l')