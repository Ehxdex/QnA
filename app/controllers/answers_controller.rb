class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user

    if @answer.save
      redirect_to @answer, notice: "Answer successfully created"
    else
      redirect_to @question, notice: "Body can't be blank"
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    redirect_to question_path(@answer.question), notice: "The answer has been deleted."
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
