class AnswersController < ApplicationController

  before_action :find_question, only: [:index]
  
  def index
    @answers = @question.answers
  end
  
  private
  
  def find_question
    @question = Question.find(params[:question_id])
  end

end
