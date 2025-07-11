class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :question_find, only: [:show, :destroy, :update, :edit]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question have successfuly saved!'
    else 
      render :new, notice: 'Not valid body or title'
    end
  end

  def show 
    @answer = Answer.new
  end

  def edit
  end

  def update
    @question.files.attach(params[:question][:files]) if params.dig(:question, :files).present?
 
    if @question.update(question_update_params)
      redirect_to @question, notice: 'Your question have successfuly updated!'
    else
      render :edit, notice: 'Bad params'
    end
  end

  def destroy 
    if current_user != @question.author
      redirect_to @question, notice: 'Only author can delete this question'
    else
      @question.destroy
      redirect_to questions_path, notice: 'Question has been succefully deleted'
    end
  end

  private

  def question_params
    params.require(:question).permit(:author_id, :title, :body, files: [])
  end

  def question_update_params
    params.require(:question).permit(:author_id, :title, :body)
  end

  def question_find
    @question = Question.with_attached_files.find(params[:id])
  end
end
