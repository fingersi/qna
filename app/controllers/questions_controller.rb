class QuestionsController < ApplicationController
  before_action :question_find, only: [:show]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)

    if @question.save
      redirect_to @question
    else 
      render :new
    end
  end

  def show 
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def question_find
    @question = Question.find(params[:id])
  end

end
