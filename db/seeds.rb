# frozen_string_literal: true

question_one = Question.create!(
  statement: 'How much is 1 + 1?',
  alternatives: [
    Alternative.new(statement: '1', correct: false),
    Alternative.new(statement: '2', correct: true),
    Alternative.new(statement: '3', correct: false),
    Alternative.new(statement: '4', correct: false)
  ]
)

question_two = Question.create!(
  statement: 'How much is 2 + 2?',
  alternatives: [
    Alternative.new(statement: '1', correct: false),
    Alternative.new(statement: '2', correct: false),
    Alternative.new(statement: '3', correct: false),
    Alternative.new(statement: '4', correct: true)
  ]
)

question_three = Question.create!(
  statement: 'Which of these are prime numbers?',
  alternatives: [
    Alternative.new(statement: '1', correct: false),
    Alternative.new(statement: '13', correct: true),
    Alternative.new(statement: '65', correct: false),
    Alternative.new(statement: '7', correct: true)
  ]
)

Quiz.create!(
  title: 'Basic Algebra',
  description: 'This is a basic algebra quiz',
  quiz_questions: [
    QuizQuestion.new(question: question_one, position: 1, weight: 30),
    QuizQuestion.new(question: question_two, position: 2, weight: 30),
    QuizQuestion.new(question: question_three, position: 3, weight: 40)
  ]
)

User.create!(email: 'user@email.com', password: 's3nh4f4c1l')
