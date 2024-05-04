# frozen_string_literal: true

class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[edit update destroy]

  def index
    @quizzes = Quiz.all
  end

  def new
    @quiz = Quiz.new
  end

  def edit; end

  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to quizzes_url, notice: 'Quiz was successfully created.' }
        format.json { head :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quizzes_url, notice: 'Quiz was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @quiz.destroy
        format.html { redirect_to quizzes_url, notice: 'Question was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
    return unless @quiz.quiz_answers.any?

    respond_to do |format|
      format.html { redirect_to quizzes_url, error: 'Cannot edit a answered quiz.' }
      format.json { render json: { error: 'Cannot edit a answered quiz.' }, status: :unprocessable_entity }
    end
  end

  def quiz_params
    params.require(:quiz).permit(
      :title, :description, quiz_questions_attributes: %i[id question_id weight position _destroy]
    )
  end
end
