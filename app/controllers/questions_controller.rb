class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create destroy ]
  before_action :set_question, only: %i[ show destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
    @answer = @question.answers.new
  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user
    render :new unless @question.save
  end

  def destroy
    @question.destroy

    flash.now[:success] = "The answer has been deleted"
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
