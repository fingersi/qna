class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:index, :create, :new, :answer_short ]
  before_action :find_answer, only: [:show, :destroy, :update]
  
  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = current_user.answers.new(answer_params)
    if @answer.save
    end
  end

  def answer_short
    @answer = current_user.answers.new(answer_params)
    if @answer.save
      notice = 'Answer successfully saved'
    else
      notice = 'Answer not saved'
    end
    redirect_to question_path(@question), notice: notice
  end

  def destroy 
    if current_user != @answer.author
      redirect_to answer_path(@answer), notice: 'Only author can delete this answer'
    else
      @answer.destroy
      redirect_to question_path(@answer.question), notice: 'Answer has been succefully deleted'
    end
  end

  def update
    @answer.update_attribute(  :body, answer_update_params[:body] )
    @question = @answer.question      
  end

  def set_best
    @answer = Answer.find(mark_best_params[:answer_id])
    if current_user.author?(@answer.question)
      @answer.set_best
    else 
      error = 'Your not question author'
    end
    redirect_to question_path(@answer.question), notice: error
  end
  
  private
  
  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.permit( :question_id, :answer, :body, :id )
  end

  def mark_best_params
    params.permit( :question_id, :answer_id )
  end

  def answer_update_params
    params.require(:answer).permit( :body )
  end
end
