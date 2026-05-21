class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable

  after_action :broadcast_comment, only: :create

  load_and_authorize_resource

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_back fallback_location: root_path, notice: 'Comment created'
    else
      redirect_back fallback_location: root_path,
                    alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

  def set_commentable
    if params[:question_id]
      @commentable = Question.find(params[:question_id])
    elsif params[:answer_id]
      @commentable = Answer.find(params[:answer_id])
    else
      redirect_back fallback_location: root_path,
                    alert: 'Commentable not found'
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def broadcast_comment
    return unless @comment&.persisted? && @comment.commentable

    question =
      case @comment.commentable
      when Question
        @comment.commentable
      when Answer
        @comment.commentable.question
      end

    return unless question

    CommentsChannel.broadcast_to(
      question,
      render_to_string(
        partial: 'comments/comment',
        locals: { comment: @comment }
      )
    )
  end
end