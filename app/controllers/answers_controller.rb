class AnswersController < ApplicationController

  include Voted

  before_action :authenticate_user!, except: %i[index show]
  
  load_and_authorize_resource :question, only: %i[index create new]
  load_and_authorize_resource :answer, through: :question, shallow: true

  before_action :answer_update_params, only: :update

  after_action :publish_answer, only: [:create]
  
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
    redirect_to @question, notice: notice
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@answer.question), notice: 'Answer has been succefully deleted'
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
    authorize! :set_best, @answer
    @answer.set_best
    redirect_to question_path(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:title, :url])
  end

  def for_link_params
    params.permit(:question_id, :answer_id, :decision)
  end

  def answer_update_params
    params.require(:answer).permit(:body, :id, files: [],  links_attributes: [:title, :url])
  end

  def publish_answer

    return unless @answer.persisted?
    
    ActionCable.server.broadcast(
      "answers_question_#{@question.id}",
      {
        id: @answer.id,
        html: ApplicationController.render(
          partial: "answers/answer",
          locals: {
            answer: @answer,
            user: current_user
          }
        )
      }
    )
  end
end
