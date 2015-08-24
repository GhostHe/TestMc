class CommentsController < ApplicationController



  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to :root
  end

  def destroy
    comment = current_user.comments.find_by(id: params[:id])
    comment.destroy
    p "111111111111111111111aaaaaaaaaaaaaaaaa"
    redirect_to root_url
  end

  private
    def comment_params
      params.require(:comment).permit!
    end


end
