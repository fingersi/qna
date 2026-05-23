class SubscriptionsController < ApplicationController
  load_and_authorize_resource :question, only: %i[create]
  load_and_authorize_resource :subscription, only: %i[destroy]

  before_action :authenticate_user!

  def create
    notice = if @subscription = @question.subscriptions.create(user: current_user)
               "You successfully subscripted to #{@question.title}."
             else
               "Something went wrong.Try again later"
             end
    redirect_to @question, notice: notice
  end

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])
    @question = @subscription.question
    notice = if @subscription.destroy
               "Your subscription to #{@question.title} removed"
             else
                "Something went wrong.Try again later"
             end
    redirect_to @question, notice: notice     
  end

end
