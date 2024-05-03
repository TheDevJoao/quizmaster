class QuestionsController < ApplicationController  
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new    
  end

  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to questions_url, notice: "Question was successfully created." }
        format.json { head :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.destroy
        format.html { redirect_to questions_url, notice: "Question was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    
  def question_params
    params.require(:question).permit(:statement, :description, alternatives_attributes: [:id, :statement, :description, :correct])
  end
end
