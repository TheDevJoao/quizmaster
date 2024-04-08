class QuizSession::Actions::CreateQuizSessionFromQuiz
  class << self
    def call(quiz_id:, user:)
      quiz = Quiz.find(quiz_id)
      
      QuizSession.find_or_create_by(user: user, quiz_snapshot: quiz_snapshot(quiz), result: nil)
    end

    private

    def quiz_snapshot(quiz)
      questions = quiz.question_quizzes.includes(:question).map do |qq|
        question = qq.question

        {
          order: qq.order,
          question_identifier: question.identifier,
          statement: question.statement,
          config: question.config.merge(qq.config || {})
        }
      end

      {
        questions: questions,
        config: quiz.config.merge(
          identitifer: quiz.identifier,
          title: quiz.title,
          description: quiz.description
        ),
        result_calculator: quiz.result_calculator
      }
    end
  end
end