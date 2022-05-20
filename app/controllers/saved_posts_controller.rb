class SavedPostsController < ApplicationController
  def create
    @post = Post.find(new_params[:post_id])
    @saved_post = SavedPost.create(new_params)
    respond_to do |format|
      if @saved_post.save
        format.html { redirect_to @post, notice: 'Post was succesfully saved.' }
        format.json { render :show, status: :created, location: @saved_post }
      else
        format.html { render :new }
        format.json { render json: @saved_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @saved_posts = SavedPost.joins(:post).where(user_id: current_user.id).collect { |saved_post| saved_post.post }
  end

  def destroy
    @post = Post.find(destroy_params[:post])
    @saved_post = SavedPost.find(destroy_params[:id])
    @saved_post.destroy

    respond_to do |format|
      format.html { redirect_to @post, notice: "Saved post was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def new_params
    params.permit(:post_id, :user_id)
  end

  def destroy_params
    params.permit(:post, :id)
  end
end
