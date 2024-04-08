class QuizSession::Actions::UpsertAnswer
  class << self
    def call(quiz_session_id:, answer:, user:, step: 1)
      session = QuizSession.find(quiz_session_id)
      
      return { failure: "User cannot access resource", status: :forbidden } unless session.user == user
      
      ActiveRecord::Base.transaction do
        upsert_answer(session, answer)
        next_step = calculate_next_step(session, step)
        calculate_result(session) unless next_step

        {
          success: {
            next_step: next_step
          }
        }
      end
    end

    private

    def upsert_answer(quiz_session, answer)
      quiz_session.answers.reject! { |a| a['question'] == answer['question'] } if quiz_session.answers
      quiz_session.answers << answer
      quiz_session.save
    end

    def calculate_next_step(quiz_session, step)
      questions_count = quiz_session.quiz_snapshot['questions']&.count
      
      if quiz_session.result
        return nil if step >= questions_count

        step + 1
      else
        answers_count = quiz_session.answers&.count || 0
        
        return nil unless questions_count && answers_count
        return nil if answers_count >= questions_count
        
        answers_count + 1
      end
    end

    def calculate_result(quiz_session)
      result_class = "Quiz::Interactions::ResultCalculators::#{quiz_session.quiz_snapshot['result_calculator']}".constantize

      quiz_session.update result: result_class.call(quiz_session: quiz_session)
    end
  end
end