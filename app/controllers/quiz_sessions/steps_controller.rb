class QuizSessions::StepsController < ApplicationController
  # GET /quiz_sessions/steps/1/edit
  def edit
    @result = QuizSession::Actions::GetStep.call(quiz_session_id: params[:quiz_session_id], user: current_user, step: params[:id])

    respond_to do |format|
      if @result[:success]
        next_step = @result[:success][:next_step]
        redirect_path = next_step ? edit_quiz_session_step_path(quiz_session_id: params[:quiz_session_id], id: next_step) : quiz_session_path(params[:quiz_session_id])

        format.html { redirect_to redirect_path }
        format.json { render :show, status: :ok, location: @quiz_session_step }
      elsif @result[:failure]
        format.html { redirect_to quiz_sessions_path, error: @result[:failure] }
        format.json { render json: @quiz_session_step.errors, status: :unprocessable_entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz_session_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quiz_sessions/steps/1 or /quiz_sessions/steps/1.json
  def update
    @result = QuizSession::Actions::UpsertAnswer.call(
      quiz_session_id: params[:quiz_session_id],
      step: params[:id].to_i,
      user: current_user,
      answer: params.require(:answer).permit!
    )

    respond_to do |format|
      if @result[:success]
        next_step = @result[:success][:next_step]
        redirect_path = next_step ? edit_quiz_session_step_path(quiz_session_id: params[:quiz_session_id], id: next_step) : quiz_session_path(params[:quiz_session_id])

        format.html { redirect_to redirect_path }
        format.json { render :show, status: :ok, location: @quiz_session_step }
      elsif @result[:failure]
        format.html { render edit_quiz_session_step_path(quiz_session_id: params[:quiz_session_id], id: next_step), status: @result[:failure][:status], errors: @result[:success] }
        format.json { render json: @quiz_session_step.errors, status: :unprocessable_entity }
      else
        format.html { render :edit, status: :unprocessable_entity, errors: @result[:failure] }
        format.json { render json: @quiz_session_step.errors, status: :unprocessable_entity }
      end
    end
  end
end
