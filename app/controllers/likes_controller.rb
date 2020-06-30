class LikesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    unless @topic.favor?(current_user)
      @topic.favor(current_user)
      @topic.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @topic = Like.find(params[:id]).topic
    if @topic.favor?(current_user)
      @topic.unfavor(current_user)
      @topic.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
