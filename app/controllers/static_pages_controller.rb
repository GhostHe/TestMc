class StaticPagesController < ApplicationController

  def home
    @micropost = Micropost.new()
    if current_user
      @microposts= Micropost.where(["user_id=?",current_user.id])
      @comment= Comment.new
    end
  end



end
