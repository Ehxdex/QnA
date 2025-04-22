class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create update destroy ]
  before_action :set_question, only: %i[ edit update show destroy]

  def index
    @questions = Question.order(created_at: :desc)
  end

  def new
    @question = Question.new
    @question.links.new
  end

  def show
    @answer = @question.answers.new
    @answer.links.new
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user
    if @question.save
    else
      render :new
    end
  end

  def destroy
    @question.destroy

    flash.now[:success] = "The question has been deleted"
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [ :name, :_destroy, :url ])
  end

  def set_question
    @question = Question.with_attached_files.find(params[:id])
  end
end
