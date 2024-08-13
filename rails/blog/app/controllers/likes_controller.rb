class LikesController < ApplicationController

  def create
    @like = Like.new
    # @like.user = current_user
    @like.post = Post.find(params[:post_id])
    @like.save
  end

  # DELETE /likes/1
  def destroy
    @like = Like.find(params[:id])
    @like.destroy
  end
end
