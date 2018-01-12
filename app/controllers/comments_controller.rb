class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_article!

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    render json: { errors: @comment.errors }, status: :unprocessable_entity unless @comment.save
  end

  def index
    @comments = @article.comments.order(created_at: :desc)
  end

  def destroy
    @comment = @article.comments.find_by(params[:id])

    if @comment.user_id = @current_user_id
      @comment.destroy
      render json: {}
    else
      render json: { errors: { comment: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def find_article!
    @article = Article.find_by_slug!(params[:article_slug])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
