class Api::V1::QuestionsController < Api::V1::BaseController 

  load_and_authorize_resource

  def index
    @questions = Question.includes(:answers, :author).all
    render json: @questions, each_serializer: QuestionSerializer
  end

  def show
    render json: @question, serializer: QuestionSerializer
  end

  def create
    @question.author = current_user
    if @question.save
      render json: @question, serializer: QuestionSerializer, status: :created
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @question.destroy
      render json: { id: @question.id, message: "Question was successfully deleted" }, status: :ok
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      render json: @question, serializer: QuestionSerializer, status: :ok
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def question_params
    params.require(:question).permit( :title, :body, links_attributes: [:title, :url])
  end

end