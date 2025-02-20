class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show ]
  before_action :set_answer, only: %i[ show ]
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show; end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question, notice: "Your question successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_answer
    @answer = @question.answers.new
  end
end
