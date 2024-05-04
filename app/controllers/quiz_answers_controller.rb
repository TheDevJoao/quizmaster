# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
class QuizAnswersController < ApplicationController
  def new
    @quiz_answer = QuizAnswer.new(quiz_id: params[:quiz_id], user_id: current_user.id)
  end

  def create
    @quiz_answer = QuizAnswer.new(quiz_answer_params.merge(quiz_id: params[:quiz_id], user_id: current_user.id))
    @quiz_answer.question_answers = @quiz_answer.question_answers.reject do |qa|
      qa.alternative_id.present? && qa.alternative_id.zero?
    end

    respond_to do |format|
      if @quiz_answer.save
        @quiz_answer.update(score:)

        format.html { redirect_to quizzes_url, notice: 'Quiz was successfully answered.' }
        format.json { head :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def score
    @quiz_answer.question_answers.group_by(&:quiz_question).sum do |(quiz_question, question_answers)|
      if quiz_question.question.multiple?
        multiple_score = question_answers.sum do |question_answer|
          weight = question_answer.quiz_question.weight

          if question_answer.alternative.correct?
            correct_alternatives = question_answer.quiz_question.question.alternatives.select(&:correct?).count

            weight / correct_alternatives
          else
            incorrect_alternatives = question_answer.quiz_question.question.alternatives.reject(&:correct?).count

            (weight / incorrect_alternatives) * -1
          end
        end

        [multiple_score, 0].max
      else
        question_answer = question_answers.last

        if question_answer.alternative.correct?
          weight = question_answer.quiz_question.weight
          correct_alternatives = question_answer.quiz_question.question.alternatives.select(&:correct?).count

          weight / correct_alternatives
        else
          0
        end
      end
    end
  end

  def quiz_answer_params
    params.require(:quiz_answer).permit(question_answers_attributes: %i[id quiz_question_id alternative_id])
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
