class StaticPagesController < ApplicationController

  def home

    if current_user
      @micropost = Micropost.new()
      @microposts= Micropost.where(["user_id=?",current_user.id])
      @comment= Comment.new
      @allmicroposts = Micropost.all
    end
  end



end
