module Voted

  extend ActiveSupport::Concern

  def vote
    return render_cannot_vote if @answer.author?(current_user)

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

  def render_cannot_vote
    render json: {
      notice: 'You cannot vote. You are author or vote before'
    }, status: :unprocessable_entity
  end

  def find_answer_link
    @answer = Answer.find(params[:answer_id])
  end

end