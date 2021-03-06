class TopicsController < ApplicationController
  def destroy
    @topic = current_user.topics.find_by(id: params[:id])
    @topic.destroy
    redirect_to current_user, success: '投稿を削除しました'
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = current_user.topics.find_by(id: params[:id])
    if @topic.update(topic_params)
      redirect_to @topic, success: '投稿を編集しました'
    else
      flash.now[:danger] = '編集できませんでした'
      render :edit
    end
  end
  
  def index
    @topics = Topic.all.includes(:favor_users)
  end
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to @topic, success: '投稿しました'
    else
      flash.now[:danger] = '投稿できませんでした'
      render :new
    end
  end
  
  private
  
  def topic_params
    params.require(:topic).permit(:image, :book_tittle, :author, :hashname, :description)
  end
end
