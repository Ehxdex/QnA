class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[edit update destroy best]
  before_action :set_question, only: %i[new create]

  def new
    @answer = @question.answers.new
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question)
    else
      render :edit
    end
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user
    render :new unless @answer.save
  end

  def destroy
    @answer.destroy
    flash.now[:success] = "The answer has been deleted"
  end

  def best
    @question = @answer.question
    @answer.set_best
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [ :name, :_destroy, :url ])
  end
end
