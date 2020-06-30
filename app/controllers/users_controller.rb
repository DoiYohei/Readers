class UsersController < ApplicationController
  
  def destroy
    @user = User.find(params[:id])
    if current_user == @user
      @user.delete
      redirect_to root_path, success: 'アカウントを削除しました'
    else
      render @user
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @favor_topics = @user.favor_topics
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_followings'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_followers'
  end
  
  def update
    @user = User.find(params[:id])
    if current_user == @user
      if @user.update(user_params)
        redirect_to @user, success: 'アカウント情報を変更しました'
      else
        flash.now[:danger] = 'アカウント情報の変更に失敗しました'
        render :edit
      end
    else
      redirect_to @user
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
    @topics = @user.topics.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user, success: '登録が完了しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:user_image, :name, :email, :password, :password_confirmation)
  end
  
end