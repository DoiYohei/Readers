class SessionController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to user, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインできませんでした'
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to root_path, info: 'ログアウトしました'
  end
  
  private

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
