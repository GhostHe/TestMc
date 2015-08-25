class StaticPagesController < ApplicationController

  def home

    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(:page => params[:page],:per_page=>25).order('id DESC')
      @comment= Comment.new
      @user= @micropost.user
    end
  end



end
