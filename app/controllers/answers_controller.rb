class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[ destroy ]
  before_action :find_question, only: %i[ create ]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user

    if @answer.save
      redirect_to @answer, notice: "Answer successfully created"
    else
      redirect_to @question, notice: "Body can't be blank"
    end
  end

  def destroy
    @answer.destroy

    redirect_to question_path(@answer.question), notice: "The answer has been deleted."
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
