class AnswersController < ApplicationController
  before_action :find_question, only: %i[ new create ]

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @answer, notice: "Answer successfully created"
    else
      render "questions/show", status: :unprocessable_entity
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
