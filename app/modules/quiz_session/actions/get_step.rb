class QuizSession::Actions::GetStep
  class << self
    def call(quiz_session_id:, user:, step: 1)
      quiz_session = QuizSession.find(quiz_session_id)
      
      return { failure: "User cannot access resource", status: :forbidden } unless quiz_session.user == user
      
      get_step_from_quiz_session(quiz_session, step.to_i)
    end

    private

    def get_step_from_quiz_session(quiz_session, step)
      question = quiz_session.quiz_snapshot['questions'].find { |q| q['order'] == step }

      Hash(question).merge(
        answer: quiz_session.answers.find { |answer| answer['question'] == question['question_identifier'] },
        previous_step: previous_step(quiz_session, step),
        last_step: last_step(quiz_session, step),
      )
    end

    def last_step(quiz_session, step)
      questions_count = quiz_session.quiz_snapshot['questions']&.count || 0
      
      step >= questions_count
    end

    def previous_step(quiz_session, step)
      return nil if step <= 1

      step - 1
    end
  end
end