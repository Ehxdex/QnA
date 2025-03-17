class AnswersController < ApplicationController
  before_action :authenticate_user!

  def new
    @answer = @question.answers.new
  end

  def show; end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user
    render :new unless @answer.save
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
