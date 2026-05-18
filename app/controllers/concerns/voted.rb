module Voted

  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: :vote
  end

  def vote
    authorize! :vote, @votable

    decision = for_link_params[:decision]
    @answer.clear_vote(current_user)

    notice = if @answer.votes.create(user: current_user, value: decision)
               'You successfully voted'
             else
               'Try again later'
             end

    render json: {
      votes: @answer.view_votes(current_user),
      notice: notice,
      answer: @answer.id,
      decision: decision
    }, status: :ok
  end

  private

  def set_votable
    votable_id = params["#{model_name}_id"] || params[:id]
    instance_record = model_klass.find(votable_id)
    @votable = instance_record 
    instance_variable_set("@#{model_name}", instance_record)
  end

  def find_answer_link
    @answer = Answer.find(params[:answer_id])
  end

  def model_klass
    controller_name.classify.constantize
  end

  def model_name
    controller_name.singularize
  end

end