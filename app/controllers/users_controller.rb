class UsersController < ApplicationController
include UsersHelper


  def new
    @user = User.new
  end

  def create
    @user= User.new(user_params)
    @user.save
    if @user.save
      log_in @user
      redirect_to root_url
    else
      render 'users/new'
    end
  end

  def show

  end

  def login
  end

  def create_login_session
    # p params[:session][:email],params[:session][:password]
    user = User.find_by_email(params[:session][:email])
    # p user
    if user && user.authenticate(params[:session][:password])

      log_in user

      redirect_to root_url
    else

      redirect_to :login
    end
  end

  def logout
    session[:user_id]= nil
    redirect_to root_url
  end


  private
    def user_params
      params.require(:user).permit(:name,:email,:password,
                                   :password_confrimation)
    end


end
