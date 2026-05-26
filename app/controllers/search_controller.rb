
class SearchController < ApplicationController
  SCOPES = {
      'questions' => Question,
      'answers'   => Answer,
      'comments'  => Comment
  }.freeze
  
  
  def index
    @query = params[:q].to_s.strip

    authorize! :read, :search 

    @query = params[:q].to_s.strip

    @current_scope = params[:scope]
    search_classes = if SCOPES[@current_scope] 
                       [SCOPES[@current_scope]]
                     else
                       [Question, Answer, Comment, User]
                     end

    @current_page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @per_page = 20

    if @query.present?
      @results = ThinkingSphinx.search(
                  @query, 
                  classes: search_classes, 
                  page: params[:page], 
                  per_page: 20 )

      @total_pages =@results.total_pages
    else
      @results = []
      @total_pages = 0
    end
  end
end