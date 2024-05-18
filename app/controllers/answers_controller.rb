class AnswersController < ApplicationController
  before_action :find_question, only: [:index, :create, :new]
  
  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to question_answer_path(@question, @answer)
    else
      render :new
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
