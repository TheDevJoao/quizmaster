class QuizAnswerCalculator
  attr_reader :quiz_answer

  def initialize(quiz_answer:)
  	@quiz_answer = quiz_answer
  end

  def calculate
  	result = quiz_answer.question_answers.sum do |question_answer|
  	  if question_answer.alternative.correct?
        weight = question_answer.quiz_question.weight
        correct_alternatives = question_answer.quiz_question.question.alternatives.select(&:correct?).count

        weight / correct_alternatives
      elsif question_answer.quiz_question.question.multiple?
        weight = question_answer.quiz_question.weight
        correct_alternatives = question_answer.quiz_question.question.alternatives.select(&:correct?).count

        (weight / correct_alternatives) * -1
      else
        0
      end
  	end

    [result, 0].max
  end
end
