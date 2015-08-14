class SessionsController < ApplicationController
  include SessionsHelper

  def new

  end


  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_url
    else
      flash[:notice] ="邮箱或密码匹配不正确！！"
      redirect_to :login
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
