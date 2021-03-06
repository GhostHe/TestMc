class MicropostsController < ApplicationController

  before_action :correct_user, only: :destroy

  def create
    @comment= Comment.new
    @micropost = current_user.microposts.build(micropost_params)
    @microposts= Micropost.where(["user_id=?",current_user.id])
     if @micropost.save
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def forwarding_micropost            # 需要修改
    # micropost = Micropost.find_by_id(params[:micropost_id])
    # p micropost.user_id
    # @micropost = current_user.microposts.create( :user_id=>current_user.id,:content=>(params[:forwarding_content]+"//"+micropost.content))
    # micropost.parent_id = current_user.id
    # p 'aaaaaaaaaaaaaaaaaaaaaaaaaaa', micropost.parent_id
    # micropost.save
    # render :json => {}

    micropost = Micropost.find_by_id(params[:micropost_id])
    @micropost = current_user.microposts.create( :content => (params[:forwarding_content]))
    @micropost.parent_id = micropost.id
    @micropost.save

    render :json  => {}
  end





  def destroy
    @micropost.destroy
    flash[:notice] = "删除成功！"
    redirect_to root_path
  end


  def is_goods
    good = Good.find_by_user_id_and_micropost_id(params[:user_id],params[:micropost_id])
    micropost = Micropost.find_by_id(params[:micropost_id])
    p good ,params[:type]
    if params[:type]==0 or good
      good.destroy
      micropost.is_good= micropost.is_good-1 if micropost and micropost.is_good.to_i>0
    else
      Good.transaction do
        Good.create(:user_id=>params[:user_id],:micropost_id=>params[:micropost_id])
        micropost.is_good= micropost.is_good.to_i+1
      end
    end
      micropost.save
      render :json => {:is_goods=> micropost.is_good}
  end

  def is_reports

    micropost = Micropost.find_by_id(params[:micropost_id])
    @report = Report.find_by_user_id_and_micropost_id(params[:user_id],params[:micropost_id])
    if params[:type].to_i==0 or @report
      @report.destroy
    p "1111111111111"
    else
      Report.transaction do
        Report.create(:user_id=>params[:user_id],:micropost_id=>params[:micropost_id],:content=>params[:report_content])
      end
    p "2222222222222"
    end
    micropost.save
    render :json => {}
  end

  private
    def micropost_params
      params.require(:micropost).permit( :user_id,:content,:picture,:parent_id)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_path if @micropost.nil?
    end

end
