class QuizAnswersController < ApplicationController
  def new
    @quiz_answer = QuizAnswer.new(quiz_id: params[:quiz_id], user_id: current_user.id)
  end

  def create
    @quiz_answer = QuizAnswer.new(quiz_answer_params.merge(quiz_id: params[:quiz_id], user_id: current_user.id))
    @quiz_answer.question_answers = @quiz_answer.question_answers.reject do |qa|
      qa.alternative_id == 0
    end

    respond_to do |format|
      if @quiz_answer.save
        result = QuizAnswerCalculator.new(quiz_answer: @quiz_answer).calculate
        @quiz_answer.update(result:)

        format.html { redirect_to quiz_url(@quiz_answer), notice: "Quiz was successfully answered." }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def quiz_answer_params
    params.require(:quiz_answer).permit(question_answers_attributes: [:id, :quiz_question_id, :alternative_id])
  end
end
