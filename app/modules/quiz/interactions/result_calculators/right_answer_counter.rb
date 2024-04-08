class Quiz::Interactions::ResultCalculators::RightAnswerCounter
  EXPERT="#1E90FF" # Dodger Blue
  PROFICIENT="#00FF7F" # Spring Green
  COMPETENT="#FFD700" # Gold
  APPRENTICE="#FFA500" # Orange
  NOVICE="#FF6347" # Tomato

  class << self
    def call(quiz_session:)
      questions = quiz_session.quiz_snapshot['questions']
      right_answers_count = quiz_session.answers.map do |answer|
        question = match_question(answer, questions)
        check_question(question, answer)
      end.inject(:+)

      answers_count = quiz_session.answers.count

      generate_result(answers_count, right_answers_count)
    end

    def match_question(answer, questions)
      questions.find { |q| q['question_identifier'] == answer['question'] }
    end

    def check_question(question, answer)
      answer['alternative'] == question.dig('config', 'correct_alternative') ? 1 : 0
    end

    def generate_result(answers_count, right_answers_count)
      case right_answers_count
      when -> (n) { n >= answers_count * 0.8 }
        { background_color: EXPERT, text: "EXPERT: #{right_answers_count}/#{answers_count}" }
      when -> (n) { n >= answers_count * 0.6 }
        { background_color: PROFICIENT, text: "PROFICIENT: #{right_answers_count}/#{answers_count}" }
      when -> (n) { n >= answers_count * 0.4 }
        { background_color: COMPETENT, text: "COMPETENT: #{right_answers_count}/#{answers_count}" }
      when -> (n) { n >= answers_count * 0.2 }
        { background_color: APPRENTICE, text: "APPRENTICE: #{right_answers_count}/#{answers_count}" }
      when -> (n) { n >= answers_count * 0.0 }
        { background_color: NOVICE, text: "NOVICE: #{right_answers_count}/#{answers_count}" }
      end.merge(
        type: :simple,
        text_color: "#FFFFFF"
      )
    end
  end
end





