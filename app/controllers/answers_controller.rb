class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:index, :create, :new, :create_short, :show, :destroy]
  before_action :find_answer, only: [:show, :destroy]
  
  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = current_user.answers.new(answer_short_params)
    if @answer.save
      redirect_to question_answer_path(@question, @answer), notice: 'Answer successfully saved'
    else
      render :new, notice: 'Answer not saved'
    end
  end

  def create_short
    @answer = current_user.answers.new(answer_short_params)
    if @answer.save
      notice = 'Answer successfully saved'
    else
      notice = 'Answer not saved'
    end
    redirect_to question_path(@question), notice: notice
  end

  def destroy 
    if current_user != @answer.author
      redirect_to question_answer_path(@question, @answer), notice: 'Only author can delete this answer'
    else
      @answer.destroy
      redirect_to question_path(@question), notice: 'Answer has been succefully deleted'
    end
  end
  
  private
  
  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end

  def answer_short_params
    params.permit(:body, :question_id)
  end
end
