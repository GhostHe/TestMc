class SessionsController < ApplicationController
  include SessionsHelper

  def new

  end


  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_url
    else
      flash[:notice] ="邮箱或密码匹配不正确！！"
      redirect_to :login
    end
  end

  def destroy
    session[:user_id]= nil
    redirect_to root_url
  end

end
