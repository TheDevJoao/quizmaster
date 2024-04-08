class QuizSessionsController < ApplicationController
  before_action :set_quiz_session, only: %i[ show edit destroy ]

  # GET /quiz_sessions or /quiz_sessions.json
  def index
    @quiz_sessions = QuizSession.for_user(current_user)
  end

  # GET /quiz_sessions/1 or /quiz_sessions/1.json
  def show
    respond_to do |format|
      if @quiz_session
        format.html
        format.json { render :show, status: :ok, location: @quiz_session }
      else
        format.html { redirect_to quiz_sessions_path, error: "Resource not Found" }
        format.json { render json: @quiz_session_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /quiz_sessions or /quiz_sessions.json
  def create
    @quiz_session = QuizSession::Actions::CreateQuizSessionFromQuiz.call(
      quiz_id: quiz_session_params[:quiz_id],
      user: current_user
    )

    respond_to do |format|
      if @quiz_session.save
        format.html { redirect_to edit_quiz_session_step_url(quiz_session_id: @quiz_session.id, id: 1) }
        format.json { render :show, status: :created, location: @quiz_session }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_sessions/1 or /quiz_sessions/1.json
  def destroy
    @quiz_session.destroy!

    respond_to do |format|
      format.html { redirect_to quiz_sessions_url, notice: "Quiz session was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz_session
      @quiz_session = QuizSession.for_user(current_user).find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quiz_session_params
      params.require(:quiz_session).permit(:quiz_id)
    end
end
