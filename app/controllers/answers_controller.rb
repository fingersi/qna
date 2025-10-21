class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[index create new answer_short]
  before_action :find_answer, only: %i[show destroy update edit]

  def index
    @answers = @question.answers
  end

  def show; end

  def new
    @answer = @question.answers.new
    @answer.links.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user
    notice = if @answer.save
               'Answer successfully saved'
             else
               'Answer not saved'
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

  def edit
    @answer.links.new
  end

  def update
    @answer.files.attach(params[:answer][:files]) if params.dig(:answer, :files).present?
    notice = if @answer.update(answer_update_params)
               'Answer successfully updated'
             else
               'Answer not updated'
             end
    @question = @answer.question
    redirect_to @question, notice: notice
  end

  def set_best
    @answer = Answer.find(mark_best_params[:answer_id])
    @answer.set_best if current_user.author?(@answer.question)
    redirect_to question_path(@answer.question)
  end

  private

  def find_question
    @question = Question.with_attached_files.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:title, :url])
  end

  def mark_best_params
    params.permit(:question_id, :answer_id)
  end

  def answer_update_params
    params.require(:answer).permit(:body, :id, links_attributes: [:title, :url])
  end
end
