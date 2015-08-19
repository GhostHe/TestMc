class StaticPagesController < ApplicationController

  def home

    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.all
      @comment= Comment.new
      @user= @micropost.user
    end
  end



end
