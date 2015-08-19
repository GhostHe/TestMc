class UsersController < ApplicationController
include UsersHelper

before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]

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

  def index
    @users= User.paginate(page: params[:page])
    @reports = Report.all
    @report = Report.find_by(params[:id])
  end

  def show
    @user= User.find(params[:id])
    @microposts= @user.microposts.all
    @comment= Comment.new
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to
    else
      render 'edit'
    end
  end

  def following
    @title="Following"
    @user =User.find(params[:id])
    @users=@user.following.all
    render 'show_follow'
  end

  def followers
    @title ="Followers"
    @user =User.find(params[:id])
    @users=@user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def changestatus
    @user= User.find(params[:id])
    if params[:type].to_i==0
      @user.update_attributes(:status=>0)
    else
      @user.update_attributes(:status=>1)
    end
    render :json=>{}
  end

  def reportinformation
    @user= User.find(params[:id])
    @reports=@user.reports
  end

  def report_viewed
    @report=Report.find_by(params[:id])
    @report.status="viewed"
    @report.save
    redirect_to users_url
  end

  def report_deleted
    @report=Report.find_by(params[:id])
    @report.status="deleted"
    @report.save
    redirect_to users_url
  end

  def report_destroy
    Report.find(params[:id]).destroy
    redirect_to users_url
  end



private

  def user_params
    params.require(:user).permit(:name,:email,:password,
                                 :password_confirmation)
  end

end
